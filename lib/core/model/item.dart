class ItemModel {
  ItemModel({
    this.name,
    this.id,
    this.body,
    this.image,
    this.price,
    this.soldBy,
    this.categoryNname,
    this.categoryId,
    this.categorySlug,
  });

  ItemModel.fromJson(dynamic  json) {
    id = json['product_id'] as String;
    name = json['product_name'] as String;
    body = json['body'] as String;
    image = json['img_path'] as String;
    soldBy = json['amount'] as String;
    price = json['amount'] as String;
    categoryId = json['category_id'] as String;
    categoryNname = json['category_name'] as String;
    categorySlug = json['category_slug'] as String;
  }

  String name;
  String id;
  String body;
  String image;
  String soldBy;
  String price;
  String categoryId;
  String categoryNname;
  String categorySlug;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = id;
    data['product_name'] = name;
    data['body'] = body;
    data['img_path'] = image;
    data['amount'] = soldBy;
    data['amount'] = price;
    data['category_name'] = price;
    data['category_id'] = categoryId;
    data['category_slug'] = price;
    return data;
  }
}



class SerialResponse {
  int status;
  String msg;
  List<Data> data;

  SerialResponse({this.status, this.msg, this.data});

  SerialResponse.fromJson(Map<String, dynamic> json) {
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
