import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q8uc/model/product_cat_model.dart';
import 'package:q8uc/ui/cart/cart_screen.dart';
import 'package:q8uc/util/constant/progressHud.dart';
import 'package:q8uc/widget/export.dart';

class BasePage extends StatefulWidget {
  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ProgressHud(
        inAsyncCall: isApiCallProcess,
        child: pageUi(context),
        opacity: 0.3,
      ),
    );
  }

  Widget pageUi(
    BuildContext context,
  ) {
    return null;
  }

  Widget buildAppBar() {
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
}
