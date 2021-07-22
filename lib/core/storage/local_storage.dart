import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/model/login_model.dart';
import 'package:q8uc/core/model/serial_model.dart';
import 'package:q8uc/ui/widgets/snackbar.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:q8uc/core/model/coupon_model.dart';

const String kUserBoxName = 'userBox';
const String kUser = 'userr';
const String kserial = 'serialss';
const String kToken = 'token';
const String kSavedBox = 'saved01';
const String kimage = 'image';
const String kcoupon = 'coupon';

class AppCache {
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<dynamic>(kUserBoxName);
  }

  // static Box<List<dynamic>> get _box => Hive.box<List<dynamic>>(kUserBoxName);

  static Box<dynamic> get _box => Hive.box<dynamic>(kUserBoxName);

  String a = '';

  static void saveUserData() {}

  static String getToken() {
    final String data = _box.get(kToken) as String;
    return data;
  }

  static void saveUser(UserModel user) {
    if (user == null) {
      return;
    }
    _box.put(kUser, user.toJson());
  }

  static void saveCoupon(CouponModel coupon) {
    // final json = jsonEncode(coupon.toJson());
    if (coupon == null) {
      return;
    }
    _box.put(kcoupon, coupon.toJson());
  }

  static void saveimage(String value) {
    _box.put(kimage, value);
  }

  static getImage() {
    _box.get(kimage);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static SerialResponse getSerial() {
    dynamic data = _box.get(kserial);
    if (data == null) {
      return null;
    }
    print(data);
    return SerialResponse.fromJson(data);
  }

  static UserModel getUser() {
    dynamic data = _box.get(kUser);
    if (data == null) {
      return null;
    }
    return UserModel.fromJson(data);
  }

  static CouponModel getCoupon() {
    dynamic data = _box.get(kcoupon);
    if (data == null) {
      return null;
    }
    return CouponModel.fromJson(data);
  }

  static bool saveJsonData(BuildContext context,
      {@required Map<String, dynamic> data}) {
    if (data == null) {
      return false;
    }

    final List<dynamic> list = getSavedData();
    for (final dynamic item in list) {
      final ItemModel i = ItemModel.fromJson(item['product']);
      if (i.id == data['product']['product_id']) {
        showSnackBar(context, 'Error', 'Item Already Exist in the bag');
        return false;
      }
    }
    if (list.length >= 10) {
      showSnackBar(context, 'Error', 'Basket can not exceed ten');
      return false;
    }
    list.add(data);
    _box.put(kSavedBox, list);

    return true;
  }

  static void removeOne(String id) {
    if (id == null) {
      return;
    }

    final List<dynamic> list = getSavedData();
    for (int index = 0; index < list.length; index++) {
      final ItemModel i = ItemModel.fromJson(list[index]['product']);
      if (i.id == id) {
        list.removeAt(index);
      }
    }

    _box.put(kSavedBox, list);
  }

  static void clear() {
    _box.clear();
  }

  static void clean(String key) {
    _box.delete(key);
  }

  static List<dynamic> getSavedData() {
    final List<dynamic> data = _box.get(kSavedBox, defaultValue: <dynamic>[]);
    if (data == null) {
      return <Map<String, dynamic>>[];
    }
    final List<dynamic> list = List<dynamic>.from(data);
    return list;
  }
}
