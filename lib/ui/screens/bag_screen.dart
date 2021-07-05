import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/core/api/actionService.dart';
import 'package:q8uc/core/api/get_serial.dart';
import 'package:q8uc/core/api/items_api.dart';
import 'package:q8uc/core/api/payment_api.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/core/view_models/items_vm.dart';
import 'package:q8uc/core/view_models/serial_vm.dart';
import 'package:q8uc/ui/screens/payment/payment3.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_button.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/custom_textfield.dart';
import 'package:q8uc/ui/widgets/custom_textspan_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/base_view.dart';
import 'package:q8uc/utils/progressHud.dart';
import 'package:q8uc/utils/router.dart';
import 'package:q8uc/utils/util.dart';
import 'package:q8uc/core/model/coupon_model.dart';

import '../../main.dart';

class BagScreen extends StatefulWidget {
  const BagScreen({Key key, this.fromCart = false, this.e, this.item})
      : super(key: key);
  final bool fromCart;

  final ItemModel item;

  final ItemModel e;

  @override
  _BagScreenState createState() => _BagScreenState();
}

class _BagScreenState extends State<BagScreen> {
  ItemModel item = ItemModel();
  ActionService actionService;
  PaymentApi paymentApi;
  ItemsApi itemsApi;
  SerialApi serialApi;
  SerialViewModel serialViewModel;
  bool checkCoupon = false;
  CouponModel couponModel;
  var couponCodeController = TextEditingController();

  List<ItemModel> allCartItems = <ItemModel>[];

  List<int> counts = <int>[];
  var totalAmount = 0.0;
  var sum = 0.0;

  bool setProgress = false;

  bool canContinue = true;

  var cummulative = 0.0;

  bool progresscummulative = false;

  List noserial = [];
  List serial = [];

  int selected = 0;

  var discount = 0.0;

  final name = 'come';

  @override
  void initState() {
    actionService = ActionService();
    paymentApi = PaymentApi();
    itemsApi = ItemsApi();
    serialApi = SerialApi();
    serialViewModel = SerialViewModel();
    couponModel = CouponModel();

    for (final dynamic val in AppCache.getSavedData()) {
      final ItemModel model = ItemModel.fromJson(val['product']);
      final eachCount = val['count'];
      allCartItems.add(model);
      counts.add(eachCount);
      setState(() {
        totalAmount = totalAmount + (double.parse(model.price) * eachCount);
        cummulative = totalAmount;
      });
      // print(totalAmount.toString());
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ItemsViewModel>(
        onModelReady: (ItemsViewModel model) => model.getCartProduct(),
        builder: (_, ItemsViewModel model, __) => ProgressHud(
            inAsyncCall: model.busy,
            opacity: 0.3,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: widget.fromCart
                  ? AppBar(
                      iconTheme: IconThemeData(color: Styles.colorWhite),
                      elevation: 0,
                      centerTitle: true,
                      backgroundColor: Styles.colorPurple,
                      title: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.shopping_bag_outlined,
                            color: Styles.colorWhite,
                            size: screenAwareSize(24, context),
                          ),
                          CustomText(
                            'Basket',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Styles.colorWhite,
                            leftMargin: 8,
                          )
                        ],
                      ),
                      actions: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: screenAwareSize(40, context),
                                height: screenAwareSize(40, context),
                                decoration: BoxDecoration(
                                    color: Styles.colorWhite,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Center(
                                    child: CustomText(
                                  counts.length.toString(),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ))),
                          ],
                        ),
                        horizontalSpaceSmall
                      ],
                    )
                  : null,
              body: Container(
                color: Styles.colorPurple,
                padding: MediaQuery.of(context).viewInsets,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView(
                    children: <Widget>[
                      verticalSpaceSmall,
                      SafeArea(
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: screenAwareSize(6, context),
                                horizontal: screenAwareSize(15, context)),
                            decoration: BoxDecoration(
                                color: Styles.colorWhite,
                                borderRadius: BorderRadius.circular(
                                    screenAwareSize(20, context))),
                            child: CustomText(
                              'Tap on  Item to remove from basket ',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Styles.colorBlack,
                            ),
                          ),
                        ),
                      ),
                      verticalSpaceSmall,
                      allCartItems.isEmpty
                          ? Center(
                              child: CustomText(
                                'Bag is Empty!',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Styles.colorWhite,
                              ),
                            )
                          : ListView.builder(
                              itemCount: allCartItems.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return bagItem(context, index);
                              }),
                      verticalSpaceMedium,
                      verticalSpaceLarge,
                      Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  fillColor: Styles.colorWhite,
                                  maxLines: 1,
                                  title: '  Coupon code (optional)',
                                  titleColor: Styles.colorWhite,
                                  controller: couponCodeController,
                                  hintText: 'Coupon code(optional)',
                                ),
                              ),
                              horizontalSpaceMedium,
                              horizontalSpaceMedium,
                              horizontalSpaceMedium,
                              Column(
                                children: [
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Checkbox(
                                      value: checkCoupon,
                                      onChanged: (onChanged) async {
                                        checkCoupon = onChanged;
                                        if (checkCoupon) {
                                          try {
                                            await serialViewModel
                                                .checkCoupon2(
                                                    couponCodeController.text)
                                                .then((respone) => {
                                                      if (respone.status == 200)
                                                        {
                                                          cummulative = totalAmount -
                                                              double.parse(AppCache
                                                                      .getCoupon()
                                                                  .discountAmount),
                                                          print(cummulative
                                                              .toStringAsFixed(
                                                                  2)),
                                                          discount = double
                                                              .parse(AppCache
                                                                      .getCoupon()
                                                                  .discountAmount)
                                                        }
                                                      else
                                                        {
                                                          cummulative =
                                                              totalAmount + 0.0,
                                                          print(cummulative
                                                              .toStringAsFixed(
                                                                  2)),
                                                        }
                                                    });
                                          } catch (e) {}
                                        } else {
                                          {
                                            cummulative = totalAmount + 0.0;
                                            discount = double.parse(
                                                    AppCache.getCoupon()
                                                        .discountAmount) -
                                                double.parse(
                                                    AppCache.getCoupon()
                                                        .discountAmount);
                                            print(discount.toString());
                                          }
                                        }
                                        setState(() {});
                                      }),
                                ],
                              )
                            ],
                          ),
                          verticalSpaceMedium,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  print(AppCache.getCoupon().discountAmount);
                                },
                                child: CustomText('Discout',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Styles.colorWhite),
                              ),
                              CustomText('\$$discount',
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Styles.colorWhite),
                            ],
                          ),
                          // verticalSpaceMedium,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  print(discount.toString());
                                },
                                child: CustomText('Total',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Styles.colorWhite),
                              ),
                              CustomText('\$${cummulative.toStringAsFixed(2)}',
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Styles.colorWhite),
                            ],
                          ),
                          SizedBox(height: screenAwareSize(20, context)),
                          InkWell(
                            onTap: () async {
                              noserial.clear();
                              model.setBusy(true);
                              for (var i in allCartItems) {
                                final result =
                                    await serialApi.checkSerialNumber(
                                  i.id,
                                );

                                if (!result) {
                                  canContinue = false;
                                  noserial.add(i.name);
                                }
                                setState(() {});
                              }
                              setState(() {});
                              if (!canContinue) {
                                model.setBusy(false);
                                showDialog<AlertDialog>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    CustomText('Error',
                                                        fontSize: 16,
                                                        bottomMargin: 10,
                                                        color: Styles.red,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ],
                                                ),
                                                RichText(
                                                  text: customTextSpan(
                                                      text:
                                                          'No available serial number for ',
                                                      context: context,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Styles.colorBlack,
                                                      children: <TextSpan>[
                                                        customTextSpan(
                                                          height: 2.0,
                                                          text: '$noserial',
                                                          context: context,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Styles
                                                              .appBackground1,
                                                        ),
                                                      ]),
                                                ),
                                                verticalSpaceTiny,
                                                verticalSpaceMedium,
                                                Row(
                                                  children: [
                                                    CustomText(
                                                      '!!Please remove from the basket',
                                                      color: Styles.red,
                                                      fontSize: 14,
                                                    ),
                                                  ],
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      CustomText(
                                                        'Close',
                                                        color: Styles.red,
                                                        fontSize: 14,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15))));
                              } else {
                                serial.clear();
                                for (var i in allCartItems) {
                                  serial.add(i.id);
                                }
                                print(serial.join(','));
                                Navigator.pop(context);
                                routeTo(
                                    context,
                                    InnerPage(
                                        discount: discount.toStringAsFixed(2),
                                        itemid: serial.join(','),
                                        totalAmount:
                                            cummulative.toStringAsFixed(2)));
                              }
                            },
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: screenAwareSize(12, context),
                                    horizontal: screenAwareSize(100, context)),
                                decoration: BoxDecoration(
                                    color: Styles.colorWhite,
                                    borderRadius: BorderRadius.circular(
                                        screenAwareSize(20, context))),
                                child: CustomText(
                                  'Checkout',
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Styles.colorBlack,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  int selectedIndex;

  void doneDialog(BuildContext context) {
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
                CustomText(
                    '${widget.item.name} has available serial number and has been added to your cart',
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
  }

  void paymentDialog(BuildContext context) {
    showDialog<AlertDialog>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
            content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              InkWell(
                onTap: () {},
                child: Container(
                  child: Row(
                    children: [
                      CustomText('VISA/MASTER',
                          fontSize: 12,
                          bottomMargin: 10,
                          color: Styles.colorBlack,
                          fontWeight: FontWeight.bold),
                    ],
                  ),
                ),
              ),
              CustomText('KNET',
                  fontSize: 16,
                  centerText: true,
                  color: Styles.colorBlack,
                  bottomMargin: 10,
                  fontWeight: FontWeight.w600),
            ]),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15))));
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
            CustomText('Serial number for ${widget.e.name} is not available',
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

  Widget bagItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        if (selectedIndex == index) {
          selectedIndex = null;
        } else {
          selectedIndex = index;
        }
        setState(() {});
      },
      child: Padding(
          padding: EdgeInsets.only(top: screenAwareSize(12, context)),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      screenAwareSize(33, context),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '${allCartItems[index].image}',
                      height: screenAwareSize(50, context),
                      width: screenAwareSize(50, context),
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Utils.progress(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(width: screenAwareSize(20, context)),
                  CustomText(
                    allCartItems[index].name,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Styles.colorWhite,
                  ),
                  Spacer(),
                  CustomText(
                    '\$${allCartItems[index].price}',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Styles.colorWhite,
                  )
                ],
              ),
              if (selectedIndex == index)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        cummulative = cummulative -
                            (double.parse(allCartItems[index].price) *
                                counts[index]);

                        cartCount.value--;

                        AppCache.removeOne(allCartItems[index].id);
                        allCartItems.removeAt(index);
                        counts.removeAt(index);
                        selectedIndex = null;
                        setState(() {});
                      },
                      child: Icon(
                        Icons.delete_outline,
                        size: screenAwareSize(26, context),
                        color: Styles.colorWhite,
                      ),
                    ),
                  ],
                ),
            ],
          )),
    );
  }
}
