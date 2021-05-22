import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:provider/provider.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/model/product_cat_model.dart';
import 'package:q8uc/ui/Dashboard/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  dynamic token = FlutterSession().get('currentUser');
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductCatModels(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProductCatModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
        // SignupPage(),
      ),
    );
  }
}
