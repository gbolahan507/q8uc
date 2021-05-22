import 'package:flutter/foundation.dart';

class ProductCatModel with ChangeNotifier {
  int productId;
  int productQty;
  String productName;
  String productPrice;
  String productLastPrice;
  String productCancelledPrice;
  String images;

  ProductCatModel({
    this.productId,
    this.productQty,
    this.productName,
    this.productPrice,
    this.productLastPrice,
    this.productCancelledPrice,
    this.images,
  });
}

class ProductCatModels with ChangeNotifier {
  List<ProductCatModel> _product = [];
  List<ProductCatModel> _basket = [];
  ProductCatModel _activeProduct = null;

  ProductCatModels() {
    _product = [
      ProductCatModel(
          productId: 1,
          images: 'images/image3.jpg',
          productName: 'PUBG WARD',
          productCancelledPrice: '400',
          productPrice: '100',
          productQty: 1,
          productLastPrice: '250'),
      ProductCatModel(
          productId: 2,
          productQty: 1,
          images: 'images/image3.jpg',
          productName: 'PUBG WARD',
          productCancelledPrice: '400',
          productPrice: '200',
          productLastPrice: '250'),
      ProductCatModel(
          productId: 3,
          productQty: 1,
          images: 'images/image3.jpg',
          productName: 'PUBG WARD',
          productCancelledPrice: '400',
          productPrice: '300',
          productLastPrice: '250'),
      ProductCatModel(
          productId: 4,
          productQty: 1,
          images: 'images/image3.jpg',
          productName: 'PUBG WARD',
          productCancelledPrice: '400',
          productPrice: '400',
          productLastPrice: '250'),
    ];

    notifyListeners(); // send notification to provider
  }

  // implement getter function that will be useful for the global varialbe

  List<ProductCatModel> get product => _product;
  List<ProductCatModel> get basket => _basket;

  ProductCatModel get activeProduct => _activeProduct;

  setActiveProduct(ProductCatModel product) {
    _activeProduct = product;
  }

  // add and remove
  addItem(ProductCatModel product) {
    ProductCatModel found = _basket.firstWhere(
        (e) => e.productId == product.productId,
        orElse: () => null);

    if (found != null) {
      found.productQty += 1;
    } else {
      _basket.add(product);
    }
    notifyListeners();
  }

  removeItem(ProductCatModel product) {
    ProductCatModel found = _basket.firstWhere(
        (e) => e.productId == product.productId,
        orElse: () => null);

    if (found != null && found.productQty == 1) {
      _basket.remove(product);
    } else {
      found.productQty -= 1;
    }
    notifyListeners();
  }

  clearBasket() {
    _basket.clear();
    notifyListeners();
  }

  getTotalBasket() {
    int total = 0;

    for (int i = 0; i < basket.length; i++) {
      total += basket[i].productQty;
    }
    notifyListeners();
    return total;
  }

  List<ProductCatModel> get items {
    return [..._product];
  }

  ProductCatModel findById(int id) {
    return _product.firstWhere((pdt) => pdt.productId == id);
  }
}
