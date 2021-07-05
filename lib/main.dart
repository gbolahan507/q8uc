import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:q8uc/ui/screens/splash_screen.dart';
import 'package:q8uc/utils/dialog_manager.dart';
import 'package:q8uc/utils/dialog_service.dart';
import 'package:q8uc/utils/navigator.dart';
import 'package:q8uc/utils/router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/storage/local_storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppCache.init(); //Initialize Hive for Flutter
  await Firebase.initializeApp();
  setupLocator();
  runApp(const MyApp());
}

ValueNotifier<int> cartCount;

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.white));
    cartCount = ValueNotifier<int>(AppCache.getSavedData().length);
    return MultiProvider(
        providers: allProviders,
        child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          locale: Locale('en'),
          supportedLocales: [
            const Locale('en'),
          ],
          theme: ThemeData(
              textTheme:
                  GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme),
              primaryColor: Colors.white,
              visualDensity: VisualDensity.adaptivePlatformDensity),
          home: SplashScreen(),
          builder: (BuildContext context, Widget child) => Navigator(
              key: locator<DialogService>().dialogNavigationKey,
              onGenerateRoute: (RouteSettings settings) =>
                  MaterialPageRoute<dynamic>(
                      builder: (BuildContext context) =>
                          DialogManager(child: child))),
          navigatorKey: locator<NavigationService>().navigationKey,
          onGenerateRoute: generateRoute,
        ));
  }
}
