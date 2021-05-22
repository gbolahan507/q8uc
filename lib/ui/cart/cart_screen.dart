import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q8uc/model/product_cat_model.dart';
import 'package:q8uc/ui/base_page.dart';
import 'package:q8uc/ui/product/product_detailPage.dart';
import 'package:q8uc/widget/custom_stepper.dart';
import 'package:q8uc/widget/export.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductCatModels>(context);

    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView.builder(
          itemCount: productData.basket.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(top: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      productData.basket[index].images,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            productData.basket[index].productName,
                            color: Styles.colorBlack,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomText(
                            productData.basket[index].productPrice,
                            topMargin: 10,
                            color: Styles.colorBlack,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          Spacer(),
                          CustomIcon(
                            icon: Icons.delete,
                            color: Styles.red,
                            size: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: CustomStepper(
                        lowerLimit: 0,
                        upperLimit: 20,
                        stepperValue: 1,
                        iconSize: 20,
                        value: productData.activeProduct.productQty,
                        onChanged: (value) {
                          print(value);
                        }),
                  )
                ],
              ),
            );
          }),
    );
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
              Container(
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
            ],
          ),
        )
      ],
    );
  }
}
