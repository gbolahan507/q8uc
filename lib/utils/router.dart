import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/ui/constants/routes.dart';
import 'package:q8uc/ui/screens/navigation_screen.dart';
import 'package:q8uc/ui/screens/signin_page.dart';
import 'package:q8uc/ui/screens/signup_page.dart';
import 'package:q8uc/ui/screens/splash_screen.dart';
import 'package:q8uc/ui/screens/confirm_gmail_sign_up.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView:
      return _getPageRoute(
        routeName: settings.name,
        view: SplashScreen(),
      );
    case LoginView:
      return _getPageRoute(
        routeName: settings.name,
        view: LoginScreen(),
      );

    case SignupView:
      return _getPageRoute(
        routeName: settings.name,
        view: SignupScreen(),
        args: settings.arguments,
      );

    case ButtomNavigationView:
      return _getPageRoute(
        routeName: settings.name,
        view: ButtomNavScreen(),
        args: settings.arguments,
      );
    case ConfirmGmailView:
      return _getPageRoute(
        routeName: settings.name,
        view: ConfirmGmailSignUp(),
        args: settings.arguments,
      );
    // case AddBusinessDoneView:
    //   return _getPageRoute(
    //     routeName: settings.name,
    //     view: const AddBusinessDone(),
    //     args: settings.arguments,
    //   );

    default:
      return CupertinoPageRoute<dynamic>(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRoute<dynamic> _getPageRoute({String routeName, Widget view, Object args}) {
  return CupertinoPageRoute<dynamic>(
      settings: RouteSettings(name: routeName, arguments: args),
      builder: (_) => view);
}

void routeTo(BuildContext context, Widget view, {bool dialog = false}) {
  Navigator.push<void>(
      context,
      CupertinoPageRoute<dynamic>(
          builder: (BuildContext context) => view, fullscreenDialog: dialog));
}

void routeToReplace(BuildContext context, Widget view) {
  Navigator.pushAndRemoveUntil<void>(
      context,
      CupertinoPageRoute<dynamic>(builder: (BuildContext context) => view),
      (Route<void> route) => false);
}
