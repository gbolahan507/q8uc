

import 'package:q8uc/model/image.dart';

class Categories {
  int productId;
  String productName;
  String productPrice;
  String productLastPrice;
  String productCancelledPrice;
   Image images;


  Categories({
    this.productId,
    this.productName,
    this.productPrice,
    this.productLastPrice,
    this.productCancelledPrice,
    this.images,

  });





Categories.fromJson(Map<String, dynamic> json){
  productId = json['productId'];
  productName = json['productName'];
  productPrice = json['productPrice'];
  productLastPrice = json['productLastPrice'];
  productCancelledPrice = json['productCancelledPrice'];

  images = json['image'] != null ? Image.fromJson(json['image']) : null;
}
}







