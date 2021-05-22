import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q8uc/model/product_cat_model.dart';
import 'package:q8uc/ui/cart/cart_screen.dart';
import 'package:q8uc/ui/product/product_detailPage.dart';
import 'package:q8uc/widget/export.dart';
import 'package:q8uc/widget/product_container.dart';

class HomePage extends StatelessWidget {
  final List<Map> myProducts =
      List.generate(100000, (index) => {"id": index, "name": "Product $index"})
          .toList();

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductCatModels>(context);
    final pdts = productData.items;
    return Scaffold(
        appBar: buildAppBar(context),
        body: Container(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  verticalSpaceMedium,
                  CarouselSlider.builder(
                      itemCount: _images.length,
                      itemBuilder: (BuildContext context, int, itemIndex) =>
                          Container(
                              child: Container(
                            color: Styles.red,
                            child: Image.asset(
                              _images[int],
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )),
                      options: CarouselOptions(
                        height: 250,
                        scrollPhysics: NeverScrollableScrollPhysics(),
                        // initialPage: 0,
                        // enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      )),
                  verticalSpaceMedium,
                  Container(
                    // color: Styles.red,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 1 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      itemCount: pdts.length,
                      itemBuilder: (BuildContext ctx, index) =>
                          ChangeNotifierProvider.value(
                              value: pdts[index],
                              child: ProductContainer(
                                tag: pdts[index].productId,
                                image: pdts[index].images,
                                productPrice: pdts[index].productPrice,
                                productLastPrice: pdts[index].productLastPrice,
                                productName: pdts[index].productName,
                                productCancelledPrice:
                                    pdts[index].productCancelledPrice,
                                onPressedAddCart: () {
                                  print('add cart');

                                  // productData
                                  //     .addItem(productData.activeProduct);
                                },
                                onTap: () {
                                  productData.setActiveProduct(
                                      productData.product[index]);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ProductDetailPage()));
                                },
                              )),
                    ),
                  )
                ],
              ),
            ),
          ],
        )));
  }

  Widget buildAppBar(BuildContext context) {
    final productData = Provider.of<ProductCatModels>(context);

    return AppBar(
      backgroundColor: Styles.colorWhite,
      iconTheme: IconThemeData(color: Styles.colorBlack),
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              CustomIcon(
                icon: Icons.notifications,
                color: Styles.colorBlack,
                size: 25,
              ),
              horizontalSpaceMedium,
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  color: Styles.appBackground1,
                  child: Column(
                    children: [
                      CustomText(
                        productData.getTotalBasket().toString(),
                        color: Styles.colorRed,
                        fontSize: 14,
                      ),
                      CustomIcon(
                        icon: Icons.shopping_cart,
                        color: Styles.colorBlack,
                        size: 20,
                        onPressed: () {
                          // CollapsingNavigationDrawer();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => CartScreen()));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  final List _images = [
    'images/image1.jpg',
    'images/image2.jpg',
  ];
}
