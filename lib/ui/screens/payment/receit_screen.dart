import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/core/api/get_serial.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/core/view_models/serial_vm.dart';
import 'package:q8uc/ui/screens/navigation_screen.dart';
import 'package:q8uc/ui/screens/order_history.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_icon.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/router.dart';
import 'package:q8uc/utils/util.dart';
import 'package:share/share.dart';

class ReceitScreen extends StatefulWidget {
  const ReceitScreen({Key key, this.itemid, this.discount, this.totalAmount})
      : super(key: key);

  final String itemid;
  final String totalAmount, discount;

  @override
  _ReceitScreenState createState() => _ReceitScreenState();
}

class _ReceitScreenState extends State<ReceitScreen> {
  String pasteValue = '';
  SerialViewModel model;
  SerialApi serialApi;

  TextEditingController field = TextEditingController();
  List<SerialResponse> seria = <SerialResponse>[];

  @override
  void initState() {
    model = SerialViewModel();
    serialApi = SerialApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: CustomText(
            'ORDER COMPLETE ',
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          actions: [
            InkWell(
              onTap: () {
                print('HELLO');
                routeTo(context, OrderHistory());
              },
              child: Column(
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  CustomText(
                    'View history ',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ],
          leading: BackButton(
            onPressed: () => routeTo(context, ButtomNavScreen()),
          ),
        ),
        body: FutureBuilder<SerialResponse>(
            future: serialApi.checkOut(
                widget.itemid,
                AppCache.getUser().custormerId.toString()),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final SerialResponse posts = snapshot.data;
                return Container(
                    color: Styles.colorLightPink,
                    padding: MediaQuery.of(context).viewInsets,
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListView(children: <Widget>[
                          verticalSpaceSmall,
                          posts.data.isEmpty
                              ? Center(
                                  child: CustomText(
                                    'Bag is Empty!',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Styles.colorWhite,
                                  ),
                                )
                              : Column(
                                  children: [
                                    CustomText(
                                      'Order Details',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Styles.appBackground1,
                                    ),
                                    verticalSpaceSmall,
                                    Container(
                                      padding: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                        color: Styles.colorWhite,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Styles.colorGreyLight,
                                              blurRadius: 4),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: posts.data.length,
                                              itemBuilder: (context, index) {
                                                return bagItem(
                                                  context,
                                                  index,
                                                  '${posts.data[index].productImgPath}',
                                                  '${posts.data[index].productName}',
                                                  '${posts.data[index].productPrice}',
                                                  '${posts.data[index].serialNumber}',
                                                );
                                              }),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                CustomText('Discount',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Styles.colorBlack),
                                                CustomText(
                                                    '\$${widget.discount}',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Styles.red),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                CustomText('Total',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Styles.colorBlack),
                                                CustomText(
                                                    '\$${widget.totalAmount}',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Styles.red),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    verticalSpaceMedium,
                                    CustomText(
                                      'Serial Number',
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Styles.appBackground1,
                                    ),
                                    verticalSpaceSmall,
                                    Container(
                                      padding: EdgeInsets.only(top: 12),
                                      decoration: BoxDecoration(
                                        color: Styles.colorWhite,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Styles.colorGreyLight,
                                              blurRadius: 4),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: posts.data.length,
                                              itemBuilder: (context, index) {
                                                return serialBag(
                                                  context,
                                                  index,
                                                  '${posts.data[index].productImgPath}',
                                                  '${posts.data[index].productName}',
                                                  '${posts.data[index].productPrice}',
                                                  '${posts.data[index].serialNumber}',
                                                );
                                              }),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(height: screenAwareSize(20, context)),
                        ])));
              } else if (snapshot.hasError) {
                return Text('error');
              }
              return new Center(
                child: new Column(
                  children: <Widget>[
                    new Padding(padding: new EdgeInsets.all(50.0)),
                    new CircularProgressIndicator(),
                  ],
                ),
              );
            }));
  }

  Widget stackBehindDismiss() {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(right: 20),
      color: Styles.colorRed,
      child: Icon(
        Icons.delete,
        color: Styles.colorWhite,
      ),
    );
  }

  Widget bagItem(BuildContext context, int index, String imageUrl, String name,
      String price, String serialNumber) {
    return Container(
      child: Padding(
          padding: EdgeInsets.only(
              bottom: screenAwareSize(12, context), left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      screenAwareSize(33, context),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '$imageUrl',
                      height: screenAwareSize(50, context),
                      width: screenAwareSize(50, context),
                      fit: BoxFit.fill,
                      placeholder: (context, url) => Utils.progress(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  SizedBox(width: screenAwareSize(20, context)),
                  CustomText(
                    '$name',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Styles.colorBlack,
                  ),
                  Spacer(),
                  CustomText(
                    '\$$price',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Styles.colorBlack,
                  )
                ],
              ),
              verticalSpaceTiny,
            ],
          )),
    );
  }

  Widget serialBag(BuildContext context, int index, String imageUrl,
      String name, String price, String serialNumber) {
    return Container(
      child: Padding(
          padding: EdgeInsets.only(
              bottom: screenAwareSize(12, context), left: 10, right: 10),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomText(
                    '$name',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Styles.colorBlack,
                  ),
                  // Spacer(),
                  horizontalSpaceMedium,
                  Expanded(
                    child: SelectableText('$serialNumber',
                        style: TextStyle(
                            color: Styles.colorRed,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                        cursorColor: Colors.red,
                        showCursor: true,
                        toolbarOptions: ToolbarOptions(
                            copy: true,
                            selectAll: true,
                            cut: true,
                            paste: false)),
                  ),
                  horizontalSpaceMedium,
                  CustomIcon(
                    icon: Icons.share,
                    size: 17,
                    color: Styles.appBackground1,
                    onPressed: () async {
                      await Share.share('$serialNumber');
                    },
                  ),
                ],
              ),
              verticalSpaceTiny,
            ],
          )),
    );
  }
}
