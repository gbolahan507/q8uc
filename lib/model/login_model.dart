class LoginResponseModel {
  bool success;
  int statusCode;
  String message;
  Data data;
 
LoginResponseModel({
  this.statusCode,
  this.data,
  this.message,
  this.success
});

LoginResponseModel.fromJson(Map<String, dynamic> json){
  success = json['success'];
  statusCode = json['statusCode'];
  message = json['message'];
  data = json['data'] != null ? Data.fromJson(json['data']) : null;
}

Map<String, dynamic> toJson(){
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['success'] = this.success;
  data['statusCode'] = this.statusCode;
  data['message'] = this.message;
  data['data'] = this.data;

  if(this.data != null){
    data['data'] = this.data.toJson();
  }
  return data;

}
}

   class Data {
     String email;
     String password;
     String username;

     Data ({
       this.email,
       this.password,
       this.username,
     });

     Data.fromJson(Map<String, dynamic> json) {
       email = json['email'];
       password = json['password'];
       username = json['username'];
     }

     Map<String, dynamic> toJson() {
       final Map<String, dynamic> data = Map<String, dynamic>();
       data['email'] = this.email;
       data['password'] = this.password;
       data['username'] = this.username;


       return data;

     }
   }

    //  }
  //  }

  // LoginResponseModel({
  //   this.email,
  //   this.password,
  // });


  // Map<String, dynamic> toJson(){
  // Map<String, dynamic> map = {};

  // map.addAll({
  //   'email ' : email,
  //   'password' : password,
  // });
  //  return map;
  // }
// }