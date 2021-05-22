import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q8uc/model/product_cat_model.dart';
import 'package:q8uc/ui/base_page.dart';
import 'package:q8uc/widget/custom_stepper.dart';
import 'package:q8uc/widget/export.dart';

class ProductDetailPage extends BasePage {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends BasePageState<ProductDetailPage> {
  int qty = 0;

  @override
  Widget pageUi(context) {
    return ProductDetailContainer();
  }
}

class ProductDetailContainer extends StatelessWidget {
  // int qty = 0;

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductCatModels>(context);

    return SingleChildScrollView(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 300,
                child: Hero(
                  tag: productData.activeProduct.productId,
                  child: Image.asset(
                    productData.activeProduct.images,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                'HOME/ ',
                fontSize: 12,
                topMargin: 10,
              ),
              CustomText(
                productData.activeProduct.productName,
                topMargin: 10,
                fontSize: 12,
              ),
            ],
          ),
          CustomText(
            '#${productData.activeProduct.productPrice}',
            topMargin: 10,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Styles.colorBlack,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomStepper(
                  lowerLimit: 0,
                  upperLimit: 20,
                  stepperValue: 1,
                  iconSize: 20,
                  value: productData.activeProduct.productQty,
                  onChanged: (value) {
                    print(value);
                  }),
              CustomFlatButton(
                onPressed: () {
                  productData.addItem(productData.activeProduct);
                },
                text: 'Add To Cart',
              ),
            ],
          ),
          verticalSpaceMedium,
          verticalSpaceMedium,
          RichText(
            text: customTextSpan(
              text: 'Shipping of PUBG packages via ID',
              context: context,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Styles.colorGrey,
              children: <TextSpan>[
                customTextSpan(
                    text: '(Immediate Delivery)',
                    context: context,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Styles.colorBlack,
                    onTap: () {}),
              ],
            ),
          ),
          verticalSpaceMedium,
          CustomText(
            'Where can i find the code ?',
            color: Styles.colorBlack,
            fontSize: 13,
            bottomMargin: 20,
          ),
          RichText(
            text: customTextSpan(
              text: 'The Shipping code arrives ',
              context: context,
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Styles.colorGrey,
              children: <TextSpan>[
                customTextSpan(
                  text: 'Immediatelly ',
                  context: context,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Styles.colorBlack,
                ),
                customTextSpan(
                  text: 'after the payment process without waiting',
                  context: context,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Styles.colorBlack,
                ),
                customTextSpan(
                  text: 'via email ',
                  context: context,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Styles.colorBlack,
                ),
                customTextSpan(
                  text: 'and the list of your request on our website ',
                  context: context,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Styles.colorGrey,
                ),
                customTextSpan(
                    text: '(click here) ',
                    context: context,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Styles.colorBlack,
                    onTap: () {}),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}

class CustomFlatButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const CustomFlatButton({
    Key key,
    this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPressed,
      child: CustomText(
        text,
        color: Styles.colorWhite,
        fontSize: 14,
      ),
      color: Styles.colorLightBlue,
      padding: EdgeInsets.all(10),
      shape: StadiumBorder(),
    );
  }
}
