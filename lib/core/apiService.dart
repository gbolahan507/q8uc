import 'package:dio/dio.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:q8uc/core/base_api.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/model/login_model.dart';
import 'package:q8uc/model/user_model.dart';



class AuthService extends BaseAPI {

  noUser() => AppStorage.setUser(UserModel(email: "no-user5%%%%"));

    Future<bool> createUser(    String email,
    String pass,) async {

        var formData = FormData();
    formData.fields.addAll([
      MapEntry("email", email),
      MapEntry("password", pass),
    ]);
    bool ret = false;
    try {
      var response = await Dio().post(
        "http://157.175.86.25/wp-admin/wpapi/v1/customer_signup.php/",
        data: formData,
        options: defaultOptions
      );
      if(response.data['status'] == 200){
        ret = true;
        print(response.data);
      } else {
        ret = false;
        print(response.data['msg'].toString());
      }
    }on DioError catch (e) {
      print(e.toString());
  //  if (e.response.statusCode == 404){
     ret = false;
  //  } else{
    //  ret = false;
   }
    // }
    return ret;
    }


    Future<LoginResponseModel> loginUser(String email, String password) async {
    LoginResponseModel model;

    try{
      var response = await Dio().post(
        "http://157.175.86.25/wp-admin/wpapi/v1/customer_login.php/",
        data: {
          "email" : email,
          "password": password,
        },
        options: defaultOptions,
      );
      if (response.data['status'] == 200){

        await FlutterSession().set('currentUser', email);
        model = LoginResponseModel.fromJson(response.data);
        print(response.data);
      } else {
        print(response.data['status'].toString());
      }
    } on DioError catch (e) {

      print(e.message);
    }
    return model;
    }
      


     


  }