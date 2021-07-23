import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() => _navigationKey.currentState.pop();

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateToReplacing(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: arguments);
  }

  void routeToReplace(BuildContext context, Widget view) {
    Navigator.pushAndRemoveUntil<void>(
        context,
        CupertinoPageRoute<dynamic>(builder: (BuildContext context) => view),
        (Route<void> route) => false);
  }

  Future<dynamic> navigateToReplacement(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> pushReplace(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }
}
