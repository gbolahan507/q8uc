import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/core/api/get_serial.dart';
import 'package:q8uc/core/api/items_api.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/core/view_models/items_vm.dart';
import 'package:q8uc/core/view_models/serial_vm.dart';
import 'package:q8uc/ui/screens/bag_screen.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/connect.dart';
import 'package:q8uc/ui/widgets/custom_button.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/base_view.dart';
import 'package:q8uc/utils/progressHud.dart';
import 'package:q8uc/utils/router.dart';
import 'package:q8uc/utils/util.dart';

import '../../main.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen({Key key, @required this.item}) : super(key: key);

  final ItemModel item;

  @override
  _ItemDetailScreenState createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  ItemModel item;
  int numberOf = 1;

  bool setprogress = false;
  SerialViewModel serialViewModel;

  ItemsApi itemsApi;
  SerialApi serialApi;
  int selected = 0;
  bool checkCoupon = false;
  var couponCodeController = TextEditingController();

  var price = 0.0;
  var discount = 0.0;
  var phone = "+96550067637";

  @override
  void initState() {
    itemsApi = ItemsApi();
    serialApi = SerialApi();
    serialViewModel = SerialViewModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    item = widget.item;
    return BaseView<ItemsViewModel>(
        onModelReady: (ItemsViewModel model) => model.getDetailProduct(),
        builder: (_, ItemsViewModel model, __) => ProgressHud(
              inAsyncCall: model.busy,
              child: Scaffold(
                backgroundColor: Styles.colorWhite,
                floatingActionButton: Connect(phone: phone),
                appBar: AppBar(
                  elevation: 0,
                  actions: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () =>
                              routeTo(context, const BagScreen(fromCart: true)),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: screenAwareSize(5, context),
                                  horizontal: screenAwareSize(8, context)),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      screenAwareSize(8, context)),
                                  color: Styles.colorRed),
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
                ),
                body: ListView(
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: '${item.image}',
                      height: screenAwareSize(300, context),
                      // width: screenAwareSize(500, context),
                      width: double.infinity,
                      placeholder: (context, url) => Utils.progress(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                    verticalSpaceSmall,
                    Center(
                      child: CustomText(
                        item.name,
                        fontSize: 14,
                        color: Styles.colorRed,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpaceTiny,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomText(
                          '\$ ${item.price}',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Styles.colorBlack,
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    AddToCart(
                      title: 'ADD TO CART',
                      onPressed: () async {
                        try {
                          setState(() {
                            model.setBusy(true);
                          });
                          await serialApi
                              .checkSerialNumber(item.id)
                              .then((ret) {
                            if (ret) {
                              model.setBusy(false);
                              doneDialog(context);
                            } else {
                              model.setBusy(false);
                              failDialog(context);
                              model.setBusy(false);
                            }
                          });
                        } catch (e) {}
                      },
                    ),
                    // verticalSpaceLarge,
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: Padding(
                    //         padding: const EdgeInsets.only(left: 20),
                    //         child: CustomTextField(
                    //           fillColor: Styles.colorDeepPink.withOpacity(0.2),
                    //           maxLines: 1,
                    //           title: '  Coupon code (optional)',
                    //           controller: couponCodeController,
                    //           hintText: 'Coupon code(optional)',
                    //         ),
                    //       ),
                    //     ),
                    //     horizontalSpaceMedium,
                    //     // horizontalSpaceMedium,
                    //     // horizontalSpaceMedium,
                    //     Padding(
                    //       padding: const EdgeInsets.only(right: 20),
                    //       child: Column(
                    //         children: [
                    //           SizedBox(
                    //             height: 25,
                    //           ),
                    //           Checkbox(
                    //               value: checkCoupon,
                    //               onChanged: (onChanged) async {
                    //                 checkCoupon = onChanged;
                    //                 if (checkCoupon) {
                    //                   try {
                    //                     await serialViewModel
                    //                         .checkCoupon2(
                    //                             couponCodeController.text)
                    //                         .then((respone) => {
                    //                               if (respone.status == 200)
                    //                                 {
                    //                                   price = double.parse(
                    //                                           item.price) -
                    //                                       double.parse(AppCache
                    //                                               .getCoupon()
                    //                                           .discountAmount),
                    //                                   discount = double.parse(
                    //                                       AppCache.getCoupon()
                    //                                           .discountAmount)
                    //                                 }
                    //                               else
                    //                                 {
                    //                                   price = double.parse(
                    //                                           item.price) +
                    //                                       0.0,
                    //                                 }
                    //                             });
                    //                   } catch (e) {}
                    //                 } else {
                    //                   {
                    //                     price = double.parse(item.price) + 0.0;

                    //                     discount = double.parse(
                    //                             AppCache.getCoupon()
                    //                                 .discountAmount) -
                    //                         double.parse(AppCache.getCoupon()
                    //                             .discountAmount);
                    //                     print(discount.toString());
                    //                   }
                    //                 }
                    //                 setState(() {});
                    //               }),
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // verticalSpaceMedium,
                    // verticalSpaceMedium,
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 20),
                    //   child: CustomButton(
                    //     title: 'CHECK OUT',
                    //     buttonColor: Styles.colorDeepGreen,
                    //     height: 50,
                    //     fontSize: 10,
                    //     onPressed: () async {
                    //       try {
                    //         model.setBusy(true);
                    //         await serialApi
                    //             .checkSerialNumber(item.id)
                    //             .then((ret) {
                    //           if (ret) {
                    //             routeTo(
                    //                 context,
                    //                 InnerPage(
                    //                     itemid: item.id.toString(),
                    //                     totalAmount: price.toString()));
                    //             model.setBusy(false);
                    //           } else {
                    //             failDialog(context);
                    //             model.setBusy(false);
                    //           }
                    //         });
                    //       } catch (e) {
                    //         model.setBusy(false);
                    //         print(e.message);
                    //       }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ));
  }

  void doneDialog(BuildContext context) {
    final Map<String, dynamic> data = <String, dynamic>{
      'product': widget.item.toJson(),
      'count': numberOf
    };

    final bool isAdded = AppCache.saveJsonData(context, data: data);
    setState(() {});
    if (isAdded) {
      cartCount.value++;
      showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CustomText('Successful',
                  fontSize: 16,
                  bottomMargin: 10,
                  color: Styles.colorBlack,
                  fontWeight: FontWeight.bold),
              CustomText('${widget.item.name} has been added to your Basket',
                  fontSize: 16,
                  centerText: true,
                  color: Styles.colorBlack,
                  bottomMargin: 10,
                  fontWeight: FontWeight.w600),
              verticalSpaceTiny,
              CustomButton(
                  title: 'View Basket',
                  onPressed: () {
                    Navigator.pop(context);
                    routeTo(context, const BagScreen(fromCart: true));
                  },
                  height: 50,
                  buttonColor: Colors.cyan),
              verticalSpaceMedium,
              CustomButton(
                  title: 'Done',
                  onPressed: () => Navigator.pop(context),
                  height: 50,
                  buttonColor: Colors.cyan),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      );
    }
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
            CustomText('Serial number for ${widget.item.name} is not available',
                fontSize: 16,
                centerText: true,
                color: Styles.colorBlack,
                bottomMargin: 10,
                fontWeight: FontWeight.w600),
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

class AddToCart extends StatelessWidget {
  final Function onPressed;
  final String title;
  final borderColor, titleColor;
  final double fontSize;
  const AddToCart({
    this.onPressed,
    this.title,
    this.borderColor,
    this.fontSize,
    this.titleColor,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
          decoration: BoxDecoration(
              border: Border.all(color: borderColor ?? Styles.red, width: 2.0)),
          child: CustomText(
            '$title',
            fontSize: fontSize ?? 12,
            color: titleColor ?? Styles.colorRed,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
