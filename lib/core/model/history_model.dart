
class HistoryModel {
  int status;
  String msg;
  List<Data> data;

  HistoryModel({this.status, this.msg, this.data});

  HistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int status;
  String statusMessage;
  String productId;
  String serialNumber;
  String productName;
  String productImgPath;
  String productPrice;

  Data(
      {this.status,
      this.statusMessage,
      this.productId,
      this.serialNumber,
      this.productName,
      this.productImgPath,
      this.productPrice});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    productId = json['product_id'];
    serialNumber = json['serial_number'];
    productName = json['product_name'];
    productImgPath = json['product_img_path'];
    productPrice = json['product_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    data['product_id'] = this.productId;
    data['serial_number'] = this.serialNumber;
    data['product_name'] = this.productName;
    data['product_img_path'] = this.productImgPath;
    data['product_price'] = this.productPrice;
    return data;
  }
}