import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/core/api/get_serial.dart';
import 'package:q8uc/core/model/history_model.dart';
import 'package:q8uc/core/model/serial_model.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/core/view_models/serial_vm.dart';
import 'package:q8uc/ui/screens/navigation_screen.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_icon.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/router.dart';
import 'package:q8uc/utils/util.dart';
import 'package:share/share.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({
    Key key,
  }) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  SerialViewModel model;
  SerialApi serialApi;
  int selectedIndex;
  HistoryModel serialResponse;
  List<HistoryModel> seria = <HistoryModel>[];
  Future futureOrder;

  getCustomerId(HistoryModel serialResponse) async {
    return await serialApi
        .getOrderHistory(AppCache.getUser().custormerId.toString());
  }

  @override
  void initState() {
    model = SerialViewModel();
    serialApi = SerialApi();
    super.initState();
    serialResponse = HistoryModel();
    futureOrder = getCustomerId(serialResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              routeTo(context, ButtomNavScreen());
            },
          ),
          title: CustomText(
            'Order History',
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        backgroundColor: Styles.appBackground1,
        body: Container(
            color: Styles.colorPurple,
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(children: <Widget>[
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
                          'swipe to right to delete history',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Styles.colorBlack,
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  FutureBuilder(
                      future: futureOrder,
                      builder: (context, snapshot) {
                        final HistoryModel posts = snapshot.data;
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return new Center(
                              child: new Column(
                                children: <Widget>[
                                  new Padding(
                                      padding: new EdgeInsets.all(50.0)),
                                  Center(
                                    child: new CircularProgressIndicator(),
                                  )
                                ],
                              ),
                            );
                          default:
                            if (snapshot.hasData) {
                              return Expanded(
                                  child: ListView.builder(
                                      itemCount: posts.data.length,
                                      itemBuilder: (context, index) {
                                        return Dismissible(
                                          key: ObjectKey(posts.data[index]),
                                          background: stackBehindDismiss(),
                                          onDismissed: (direction) async {
                                            await serialApi
                                                .deleteProduct(
                                                  '${posts.data[index].serialNumber}',
                                                )
                                                .then((value) => {
                                                      if (value.status == 200)
                                                        {
                                                          setState(() {
                                                            posts.data.removeAt(
                                                                index);
                                                          }),
                                                        }
                                                    });
                                            setState(() {});
                                          },
                                          child: bagItem(
                                            context,
                                            index,
                                            '${posts.data[index].productImgPath}',
                                            '${posts.data[index].productName}',
                                            '${posts.data[index].productPrice}',
                                            '${posts.data[index].serialNumber}',
                                          ),
                                        );
                                      }));
                            } else {
                              return Center(
                                child: new Column(
                                  children: <Widget>[
                                    new Padding(
                                        padding: new EdgeInsets.all(50.0)),
                                    verticalSpaceLarge,
                                    verticalSpaceLarge,
                                    verticalSpaceLarge,
                                    Center(
                                      child: new CustomText(
                                        'Order list is empty',
                                        fontSize: 13,
                                        color: Styles.colorWhite,
                                      ),
                                    ),
                                    verticalSpaceMedium,
                                    InkWell(
                                      onTap: () {
                                        routeTo(context, ButtomNavScreen());
                                      },
                                      child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Styles.colorRed),
                                          child: CustomText(
                                            'Home',
                                            fontSize: 12,
                                            color: Styles.colorWhite,
                                          )),
                                    )
                                  ],
                                ),
                              );
                            }
                        }
                      })
                ]))));
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

  Widget bagItem(
    BuildContext context,
    int index,
    String imageUrl,
    String name,
    String price,
    String serialNumber,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      decoration: BoxDecoration(
        color: Styles.colorWhite,
        boxShadow: <BoxShadow>[
          BoxShadow(color: Styles.colorGreyLight, blurRadius: 4),
        ],
      ),
      child: Padding(
          padding: EdgeInsets.only(
              top: screenAwareSize(2, context), left: 10, right: 10),
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
                  ),
                ],
              ),
              verticalSpaceSmall,
              Row(
                children: [
                  SelectableText(
                    '$serialNumber',
                      style: TextStyle(
                          color: Styles.colorRed,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      cursorColor: Colors.red,
                      showCursor: true,
                      toolbarOptions: ToolbarOptions(
                          copy: true,
                          selectAll: true,
                          cut: false,
                          paste: false)),
                  Spacer(),
                  CustomIcon(
                    icon: Icons.share,
                    size: 15,
                    onPressed: () async {
                      await Share.share('$serialNumber');
                    },
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
