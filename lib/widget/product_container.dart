import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q8uc/model/categories.dart';
import 'package:q8uc/model/product_cat_model.dart';
import 'package:q8uc/widget/export.dart';

class ProductContainer extends StatelessWidget {
  final image;
  final String productPrice;
  final String productName;
  final String productLastPrice;
  final String productCancelledPrice;
  final bool network;
  final Categories data;
  final Function onTap;
  final Function onPressedAddCart;
  final tag;

  const ProductContainer({
    Key key,
    this.image,
    this.tag,
    this.network = false,
    this.productCancelledPrice,
    this.data,
    this.onPressedAddCart,
    this.onTap,
    this.productPrice,
    this.productName,
    this.productLastPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductCatModels>(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            // color: Styles.colorLightBlue,
            boxShadow: const <BoxShadow>[
              BoxShadow(
                offset: Offset(1, 1),
                color: Colors.black12,
                spreadRadius: 1,
                blurRadius: 10,
              )
            ],
          ),
          child: Column(
            children: [
              Container(
                // color: Styles.red,
                height: screenAwareSize(200, context),
                width: screenAwareSize(150, context, width: true),
                child: network
                    ? Image.network('image')
                    : Hero(
                        tag: tag, child: Image.asset(image, fit: BoxFit.cover)),
              ),
              verticalSpaceTiny,
              CustomText(productName, fontSize: 12),
              CustomText('Price $productPrice', topMargin: 10, fontSize: 14),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                CustomText(productLastPrice,
                    topMargin: 10, fontSize: 14, color: Styles.colorBlack),
                horizontalSpaceTiny,
                CustomText(productCancelledPrice,
                    decoration: TextDecoration.lineThrough,
                    topMargin: 10,
                    fontSize: 16,
                    color: Styles.colorBlack),
              ]),
              verticalSpaceSmall,
              verticalSpaceTiny,
              InkWell(
                onTap: onPressedAddCart,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  child: CustomButton(
                    title: 'ADD TO CART',
                    fontSize: 12,
                    height: 40,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
