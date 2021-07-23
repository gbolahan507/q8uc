import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_fatoorah/my_fatoorah.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/main.dart';
import 'package:q8uc/ui/screens/bag_screen.dart';
import 'package:q8uc/ui/screens/payment/receit_screen.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/router.dart';

class PaymentPage extends StatelessWidget {
  final ItemModel item;
  final String itemid;
  final String totalAmount, discount;

  final List<ItemModel> allCartItems = <ItemModel>[];
  List serial = [];

  PaymentPage({this.item, this.itemid, this.totalAmount, this.discount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Builder(
        builder: (BuildContext context) {
          return MyFatoorah(
            buildAppBar: (callback) => AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
              ),
            ),
            request: MyfatoorahRequest.test(
              token:
                  'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
              currencyIso: Country.SaudiArabia,
              successUrl:
                  'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
              errorUrl:
                  'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
              invoiceAmount: double.parse('${totalAmount.toString()}'),
              language: ApiLanguage.English,
            ),
            errorChild: Center(
              child: Icon(
                Icons.error,
                color: Colors.redAccent,
                size: 50,
              ),
            ),
            succcessChild: Center(
              child: Icon(
                Icons.done_all,
                color: Colors.greenAccent,
                size: 50,
              ),
            ),
            afterPaymentBehaviour: AfterPaymentBehaviour.AfterCalbacksExecution,
            onResult: (PaymentResponse res) {
              if (res.isSuccess) {
                routeTo(
                    context,
                    ReceitScreen(
                        discount: discount,
                        itemid: itemid,
                        totalAmount: totalAmount));
              } else {
                print('fail');
                failureDialog(context);
              }
            },
          );
        },
      ),
    );
  }

  void failureDialog(BuildContext context) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: CustomText('Error!!',
                      fontSize: 16,
                      bottomMargin: 10,
                      color: Styles.colorRed,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText('Payment UnSuccessful',
                    fontSize: 16,
                    bottomMargin: 10,
                    color: Styles.colorBlack,
                    fontWeight: FontWeight.bold),
              ],
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Spacer(),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: CustomText(
                    'close',
                    color: Styles.red,
                  ),
                ),
              ],
            )
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return AppBar(
      backwardsCompatibility: true,
      iconTheme: IconThemeData(color: Styles.colorBlack),
      elevation: 0,
      title: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            return CustomText(
              snapshot.hasData ? user.displayName : AppCache.getUser().username,
              fontSize: 14,
              color: Styles.colorBlack,
            );
          }),
      actions: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () => routeTo(context, const BagScreen(fromCart: true)),
              child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: screenAwareSize(5, context),
                      horizontal: screenAwareSize(8, context)),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(screenAwareSize(8, context)),
                      color: Styles.colorPurpleLight),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.shopping_bag_outlined,
                        color: Styles.colorWhite,
                        size: screenAwareSize(22, context),
                      ),
                      ValueListenableBuilder<int>(
                          valueListenable: cartCount,
                          builder: (_, int value, __) {
                            return CustomText(
                              value.toString(),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Styles.colorWhite,
                              leftMargin: 8,
                            );
                          })
                    ],
                  )),
            ),
          ],
        ),
        horizontalSpaceSmall
      ],
    );
  }
}
