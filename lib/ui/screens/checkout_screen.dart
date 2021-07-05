import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/view_models/items_vm.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_button.dart';
import 'package:q8uc/ui/widgets/custom_icon.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/custom_textspan_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/base_view.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({Key key, @required this.item}) : super(key: key);

  final ItemModel item;

  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  int numberOf = 1;
  ItemModel item = ItemModel();
  List<ItemModel> allCartItems = <ItemModel>[];

  @override
  Widget build(BuildContext context) {
    item = widget.item;
    return Scaffold(
        backgroundColor: Styles.colorWhite,
        appBar: AppBar(
          elevation: 0,
        ),
        body: BaseView<ItemsViewModel>(
            onModelReady: (ItemsViewModel model) => model.getDetailProduct(),
            builder: (_, ItemsViewModel model, __) => Padding(
                padding: EdgeInsets.all(screenAwareSize(20, context)),
                child: ListView(children: <Widget>[
                  // ListView.builder(
                  //     shrinkWrap: true,
                  //     physics: NeverScrollableScrollPhysics(),
                  //     itemCount: allCartItems.length,
                  //     itemBuilder: (context, index) {
                  //       return CustomText(widget.item.name);
                  //     }),
                  // CustomerDetail(
                  //   icon: Icons.person,
                  //   text: '${AppCache.getUser().email}',
                  // ),
                  // CustomerDetail(
                  //   icon: Icons.phone,
                  //   text: '${AppCache.getUser().custormerId}',
                  // ),

                  // CustomerDetail(
                  //   icon: Icons.location_searching,
                  //   text: '${AppCache.getUser().email}',
                  // ),

                  verticalSpaceMedium,

                  Divider(
                    color: Styles.colorGrey,
                  ),
                  verticalSpaceMedium,

                  // Image.network(
                  //   item.image,
                  //   height: screenAwareSize(200, context),
                  //   //  fit: BoxFit.fitWidth,
                  // ),
                  SizedBox(height: screenAwareSize(15, context)),
                  // Center(
                  //   child: CustomText(
                  //     item.name,
                  //     fontSize: 16,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),

                  SizedBox(height: screenAwareSize(40, context)),

                  Row(
                    children: [
                      CustomText(
                        'PRICE',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Styles.colorBlack,
                      ),
                      Spacer(),
                      //     CustomText(
                      //       '\$${item.price}',
                      //       fontSize: 20,
                      //       fontWeight: FontWeight.bold,
                      //       color: Styles.colorBlack,
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: screenAwareSize(20, context)),

                      RichText(
                        text: customTextSpan(
                          text: 'The Shipping code arrives ',
                          context: context,
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Styles.colorGreyLight,
                          children: <TextSpan>[
                            customTextSpan(
                              height: 2.0,
                              text: 'Immediatelly ',
                              context: context,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Styles.colorBlack,
                            ),
                            customTextSpan(
                              height: 2.0,
                              text:
                                  'after the payment process without waiting',
                              context: context,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Styles.colorBlack,
                            ),
                            customTextSpan(
                              text: 'via email ',
                              height: 2.0,
                              context: context,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Styles.colorBlack,
                            ),
                            customTextSpan(
                              text:
                                  'and the list of your request on our website ',
                              context: context,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Styles.colorGreyLight,
                            ),
                            customTextSpan(
                                text: '(click here) ',
                                context: context,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Styles.colorBlack,
                                onTap: () {}),
                          ],
                        ),
                      ),

                      verticalSpaceLarge,
                      Padding(
                        padding: EdgeInsets.all(screenAwareSize(20, context)),
                        child: CustomButton(
                            title: 'Proceed to checkout',
                            busy: model.busy,
                            height: screenAwareSize(50, context),
                            buttonColor: Styles.colorPurpleLight,
                            onPressed: () {
                              paymentMethodDialog(context);
                            }),
                      ),
                    ],
                  ),
                ]))));
  }

  successfunction() {
    print('sucess');
  }

  failurefunction() {
    print('failure');
  }

  Widget detailsItem(
      BuildContext context, IconData icon, String title, String subtitle) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          color: Styles.colorPurpleLight,
        ),
        horizontalSpaceSmall,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText(
              title,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Styles.colorGrey,
            ),
            Center(
              child: CustomText(
                subtitle,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Styles.colorBlack,
              ),
            ),
          ],
        )
      ],
    );
  }

  void paymentMethodDialog(BuildContext context) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CustomText('Choose Payment Method',
                fontSize: 12,
                bottomMargin: 20,
                color: Styles.colorBlack,
                fontWeight: FontWeight.bold),
            GestureDetector(
              onTap: () {
                // Navigator.pop(context);
                // routeTo(context, VisaPaymentScreen(item: item));
              },
              child: Row(
                children: [
                  CustomText('VISA/MASTER CARD',
                      fontSize: 18,
                      centerText: true,
                      color: Styles.colorLightBlue,
                      bottomMargin: 20,
                      fontWeight: FontWeight.w600),
                ],
              ),
            ),
            Row(
              children: [
                CustomText('KNET',
                    fontSize: 20,
                    centerText: true,
                    color: Styles.colorNavGreen,
                    bottomMargin: 10,
                    fontWeight: FontWeight.w600),
              ],
            ),
            verticalSpaceMedium,
            CustomButton(
                title: 'Close',
                onPressed: () => Navigator.pop(context),
                height: 50,
                buttonColor: Colors.cyan),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  void failDialog(BuildContext context) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText('Sorry',
                    fontSize: 16,
                    bottomMargin: 10,
                    color: Styles.red,
                    fontWeight: FontWeight.bold),
              ],
            ),
            // CustomText('Serial number for ${widget.item.name} is not available',
            //     fontSize: 16,
            //     centerText: true,
            //     color: Styles.colorBlack,
            //     bottomMargin: 10,
            //     fontWeight: FontWeight.w600),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: CustomText(
                    'close',
                    color: Styles.appBackground2,
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
}

class CustomerDetail extends StatelessWidget {
  final icon;
  final String text;

  CustomerDetail({
    this.icon,
    this.text,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomIcon(
          icon: icon,
        ),
        horizontalSpaceMedium,
        CustomText('$text', color: Styles.colorBlack),
      ],
    );
  }
}
