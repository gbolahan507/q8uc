import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:q8uc/core/api/auth_api.dart';
import 'package:q8uc/core/model/login_model.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/ui/constants/routes.dart';
import 'package:q8uc/ui/screens/navigation_screen.dart';
import 'package:q8uc/ui/widgets/snackbar.dart';
import 'package:q8uc/utils/custom_exception.dart';

import '../../locator.dart';
import 'base_vm.dart';

class AuthViewModel extends BaseModel {
  final AuthApi _authApi = locator<AuthApi>();
  String error1;
  String error2;
  String error3;

  UserModel userModel;
  UserCredential userCredential;

  Future<void> loginUser(BuildContext context, Map<String, String> data) async {
    setBusy(true);
    try {
      userModel = await _authApi.loginUser(data);
      AppCache.saveUser(userModel);
      navigate.routeToReplace(context, ButtomNavScreen());
      setBusy(false);
      notifyListeners();
    } on CustomException catch (e) {
      error2 = e.message;
      setBusy(false);
      showSnackBar(context, 'Error', 'Incorrect Username or password');
      // showErrorDialog(e);
      notifyListeners();
    }
  }

  Future<void> createUsers(
    BuildContext context,
    String email,
    String password,
    String username,
    String phone,
  ) async {
    setBusy(true);
    try {
      print(2);
      await _authApi.createUser(email, password, username, phone);

      dialog.showDialog(
          title: 'Success', description: 'Login into your account');
      dialog.showSnackBar(context, 'Sucess', 'Login into your account');
      setBusy(false);
      navigate.navigateToReplacing(LoginView);
      notifyListeners();
    } on CustomException catch (e) {
      error1 = e.message;
      setBusy(false);
      showErrorDialog(e);
      notifyListeners();
      return null;
    }
  }

  Future<bool> googleSignUp(BuildContext context) async {
    bool ret;
    try {
      await _authApi.googleSignUp();
      navigate.navigateTo(ConfirmGmailView);
      ret = true;
      setBusy(false);
      notifyListeners();
    } on CustomException catch (e) {
      error1 = e.message;
      setBusy(false);
      ret = false;
      showErrorDialog(e);
      notifyListeners();
    }
    return ret;
  }

  Future<void> confirmGmail(
      BuildContext context, Map<String, String> data) async {
    setBusy(true);
    try {
      userModel = await _authApi.confirmGmail(data);
      AppCache.saveUser(userModel);
      navigate.routeToReplace(context, ButtomNavScreen());
      setBusy(false);
      notifyListeners();
    } on CustomException catch (e) {
      error2 = e.message;
      setBusy(false);
      showSnackBar(context, 'Error', 'Incorrect Username or password');
      notifyListeners();
    }
  }

  Future<void> facebookSignIn() async {
    try {
      await _authApi.facebookSignIn();
      navigate.navigateTo(ButtomNavigationView);
      setBusy(false);
      notifyListeners();
    } on CustomException catch (e) {
      error1 = e.message;
      setBusy(false);
      showErrorDialog(e);

      notifyListeners();
      return null;
    }
  }

  logout() async {
    _authApi.logOut();
    navigate.navigateTo(SignupView);
    SystemNavigator.pop();

    notifyListeners();
  }

  void showErrorDialog(CustomException e) {
    dialog.showDialog(
        title: 'Error', description: e.message, buttonTitle: 'Close');
  }
}
