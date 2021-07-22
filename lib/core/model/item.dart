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



