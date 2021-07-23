import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/core/model/login_model.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/ui/constants/routes.dart';
import 'package:q8uc/ui/screens/signin_page.dart';
import 'base_vm.dart';

class StartUpViewModel extends BaseModel {
  bool hasLoggedIn = false;
  final _auth = FirebaseAuth.instance;
  bool get isSignedIn => _auth.currentUser != null;

  Future<void> isLoggedIn() async {
    final UserModel token = AppCache.getUser();
    if (token != null) {
      hasLoggedIn = true;
      Future<void>.delayed(const Duration(seconds: 2), () {
        navigate.navigateToReplacement(ButtomNavigationView);
      });
    } else
      Future<void>.delayed(const Duration(seconds: 2), () {
        navigate.navigateToReplacement(SignupView);
      });

    notifyListeners();
  }

  Future handleAuth() async {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            hasLoggedIn = true;
            Future<void>.delayed(const Duration(seconds: 2), () {
              navigate.navigateToReplacing(ButtomNavigationView);
            });

            // });
          } else
            // Future<void>.delayed(const Duration(seconds: 2), () {
            Future<void>.delayed(const Duration(seconds: 2), () {
              navigate.navigateToReplacing(SignupView);
            });
          return LoginScreen();
        });
  }
}
