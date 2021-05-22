class CartReQuestModel {
  int userId;
  List<CartProduct> products;

  CartReQuestModel({this.products, this.userId});

  CartReQuestModel.fromJson(Map<String, dynamic> json) {
       userId = json['userId'];
       if(json['products'] != null){
         products = List<CartProduct>();
         json['product'].forEach((v){
           products.add(CartProduct.fromJson(v));
         });
       }
     }
    Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['userId'] = this.userId;
    if(this.products != null){
    data['products'] = this.products.map((v) => v.toJson()).toList();

    }
    return data;
  }
}



class CartProduct{
  int productId;
  int quantity;

  CartProduct({
    this.productId, this.quantity
  });

  CartProduct.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    return data;

  }
}