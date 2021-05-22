import 'package:hive/hive.dart';
import 'package:q8uc/model/user_model.dart';
import 'package:path_provider/path_provider.dart';

const String kUserBoxName = "user_details";

class AppStorage {
  static Future<void> init() async {
  final appDocDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocDir.path);  
    await Hive.openBox(kUserBoxName);
  }

  static Box get _box => Hive.box(kUserBoxName);

  static bool containsKey(String key) => _box.containsKey(key);

  static UserModel get currentUser {
    if (_box.containsKey('user')) {
      Map<String, dynamic> json = new Map<String, dynamic>.from(_box.get('user'));
      UserModel user = UserModel.fromJson(Map.from(json));
      return user;
    } else {
      return null;
    }
  }

  static String get defaultWallet {
    if (_box.containsKey('wallet')) {
      return _box.get('wallet');
    } else {
      return null;
    }
  }

  static void setUser(UserModel user) async {
    await _box.put('user', user.toJson());
  }

  static void setDefaultWallet(String type) async {
    await _box.put('wallet', type);
  }

  static Future<void> clean() async {
    await _box.deleteAll(["user"]);
  }
}
