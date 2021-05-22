class UserModel {
  String email;
  String password;



  UserModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }

  // Map<String, dynamic> toJson(){
  // Map<String, dynamic> map = {};

  // map.addAll({
  //   'email ' : email,
  //   'password' : password,
  // });
  //  return map;
  // }

    UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    }

  
}