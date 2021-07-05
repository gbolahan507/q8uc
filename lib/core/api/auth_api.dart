import 'dart:async';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:q8uc/core/model/error_model.dart';
import 'package:q8uc/core/model/login_model.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/ui/constants/messages.dart';
import 'package:q8uc/utils/custom_exception.dart';
import 'package:q8uc/utils/error_util.dart';
import 'package:logger/logger.dart';
import 'base_api.dart';

class AuthApi extends BaseAPI {
  Logger log = Logger();

  // Firebase _auth = Firebase.
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final googgleSignIn = GoogleSignIn();
  // final facebookSignIn = facebookSignIn();

  GoogleSignInAccount _user;

  GoogleSignInAccount get user => _user;

  Future<UserModel> loginUser(Map<String, String> data) async {
    var formData = FormData.fromMap(data);
    try {
      final Response<Map<String, dynamic>> res =
          await dio.post<Map<String, dynamic>>("$baseUrl/customer_login.php/",
              data: formData, options: defaultOptions);

      log.d(res.data);
      switch (res.data["status"]) {
        case SERVER_OKAY:
          return UserModel.fromJson(res.data);
          break;
        case WRONG_SERVER:
          throw UNKNOWN_USER;
          break;
        case SERVER_ERROR:
          throw SERVER_DOWN;
          break;
        default:
          throw ErrorModel.fromJson(res.data);
      }
    } catch (e) {
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<UserModel> createUser(
    String email,
    String password,
    String username,
    String phone,
  ) async {
    var formData = FormData();
    formData.fields.addAll([
      MapEntry("email", email),
      MapEntry("password", password),
      MapEntry("username", username),
      MapEntry("phone", phone),
    ]);

    try {
      var response = await Dio().post("$baseUrl/customer_signup.php/",
          data: formData, options: defaultOptions);
      log.d(response.data["msg"]);
      if (response.data["status"] == 200) {
        final UserModel user = UserModel.fromJson(response.data);
        return user;
      } else {
        throw 'user already exist';
      }
    } catch (e) {
      print(e);
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  // google Signup

  Future<UserCredential> googleSignUp() async {
    final googleUser = await googgleSignIn.signIn();
    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserModel> confirmGmail(Map<String, String> data) async {
    var formData = FormData.fromMap(data);
    try {
      final Response<Map<String, dynamic>> res = await dio
          .post<Map<String, dynamic>>("$baseUrl/validate_gmail_user.php/",
              data: formData, options: defaultOptions);

      log.d(res.data);
      switch (res.data["status"]) {
        case SERVER_OKAY:
          return UserModel.fromJson(res.data);
          break;
        case WRONG_SERVER:
          throw UNKNOWN_USER;
          break;
        case SERVER_ERROR:
          throw SERVER_DOWN;
          break;
        default:
          throw ErrorModel.fromJson(res.data);
      }
    } catch (e) {
      throw CustomException(DioErrorUtil.handleError(e));
    }
  }

  facebookSignIn() async {
    final fb = FacebookLogin();

// Log in
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

// Check result status
    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in

        // Send access token to server for validation and auth
        final FacebookAccessToken accessToken = res.accessToken;
        final facebookAuthCredential =
            FacebookAuthProvider.credential(accessToken.token);
        print('Access token: ${accessToken.token}');

        return await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

  logOut() async {
    AppCache.clear();
    _auth.signOut();
   
    // await googgleSignIn.signOut();
  }
}
