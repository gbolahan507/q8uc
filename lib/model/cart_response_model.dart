class CartResponseModel {
  bool status;
  List<CartItem> data;

  CartResponseModel.fromJson(Map<String, dynamic> json) {
       status = json['status'];
       if(json['data'] != null){
         data = List<CartItem>();
         json['data'].forEach((v){
           data.add(CartItem.fromJson(v));
         });
       }
     }

    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if(this.data != null){
    data['data'] = this.data.map((v) => v.toJson()).toList();

    }
    return data;

  }
}



class CartItem{
  int productId;
  int quantity;
  String productName;
  String productPrice;
  String productSalePrice;
  

  CartItem({
    this.productId,
     this.quantity,
     this.productName,
     this.productPrice,
     this.productSalePrice,
  });

  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productSalePrice = json['productSalePrice '];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    data['productName'] = this.productName;
    data['productPrice'] = this.productPrice;
    data['productSalePrice'] = this.productSalePrice;

    return data;

  }
}