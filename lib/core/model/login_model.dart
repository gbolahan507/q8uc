class UserModel {
  int status;
  String msg;
  dynamic userId;
  dynamic frame;
  dynamic lname;
  String email;
  String custormerId;
  String password;
  String username;
  String phone;
  dynamic country;
  dynamic state;
  dynamic city;
  dynamic dateLastActive;
  dynamic dateRegistered;

  UserModel({
    this.status,
    this.msg,
    this.userId,
    this.frame,
    this.lname,
    this.phone,
    this.email,
    this.custormerId,
    this.country,
    this.city,
    this.state,
    this.dateLastActive,
    this.dateRegistered,
  });

  UserModel.fromJson(dynamic json) {
    status = json['status'];
    msg = json['msg'];
    userId = json['user_id'];
    frame = json['frame'];
    lname = json['lname'];
    email = json['email'];
    custormerId = json['customer_id'];
    country = json['country'];
    city = json['city'];
    username = json['username'];
    phone = json['phone'];
    state = json['state'];
    dateLastActive = json['date_last_active'];
    dateRegistered = json['date_registered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['user_id'] = this.userId;
    data['frame'] = this.frame;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['customer_id'] = this.custormerId;
    data['country'] = this.country;
    data['city'] = this.city;
    data['state'] = this.state;
    data['phone'] = this.phone;
    data['username'] = this.username;
    data['date_last_active'] = this.dateLastActive;
    data['date_registered'] = this.dateRegistered;

    return data;
  }
}
