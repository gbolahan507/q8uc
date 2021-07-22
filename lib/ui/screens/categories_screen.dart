import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/view_models/connectivity_vm.dart';
import 'package:q8uc/core/view_models/items_vm.dart';
import 'package:q8uc/main.dart';
import 'package:q8uc/ui/screens/bag_screen.dart';
import 'package:q8uc/ui/screens/categories/category_screen/pubg_screen.dart';
import 'package:q8uc/ui/screens/categories/category_screen/itun_screen.dart';
import 'package:q8uc/ui/screens/categories/category_screen/play_station.dart';
import 'package:q8uc/ui/screens/categories/category_screen/google_play.dart';

import 'package:q8uc/ui/screens/drawer/app_drawer.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/connect.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/base_view.dart';
import 'package:q8uc/utils/router.dart';
import 'package:q8uc/utils/util.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:q8uc/ui/widgets/error_widget.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final SolidController solidController = SolidController();
  int selected = 0;
  var phone = "+96550067637";

  ConnectionViewModel model;

  @override
  void initState() {
    super.initState();
    model = ConnectionViewModel();
    model.startMonitoring(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Styles.colorWhite,
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(60), child: MyAppBar()),
      drawer: AppDrawer(),
      floatingActionButton: Connect(phone: phone),
      body: GestureDetector(
        onTap: () {
          Utils.offKeyboard(context);
          solidController.hide();
        },
        child: StreamBuilder<bool>(
            stream: solidController.isOpenStream,
            initialData: false,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return BaseView<ItemsViewModel>(
                  onModelReady: (ItemsViewModel model) =>
                      model.getProductCategories(),
                  builder: (_, ItemsViewModel model, __) => SafeArea(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              child: ListView(
                                children: [
                                  CarouselSlider.builder(
                                      itemCount: _images.length,
                                      itemBuilder: (BuildContext context, int,
                                              itemIndex) =>
                                          Container(
                                              child: Container(
                                            color: Styles.red,
                                            child: Image.asset(
                                              _images[int],
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                      options: CarouselOptions(
                                        height: 250,
                                        scrollPhysics:
                                            NeverScrollableScrollPhysics(),
                                        reverse: false,
                                        autoPlay: true,
                                        autoPlayInterval: Duration(seconds: 2),
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 800),
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        enlargeCenterPage: true,
                                        scrollDirection: Axis.horizontal,
                                      )),
                                  verticalSpaceMedium,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ProductButton(
                                        text: 'Categories',
                                        color: Styles.red,
                                      ),
                                    ],
                                  ),
                                  verticalSpaceMedium,
                                ],
                              ),
                            ),

                            model.busy
                                ? Expanded(
                                    child: ListView(
                                      children: [
                                        const Center(
                                            child:
                                                CupertinoActivityIndicator()),
                                      ],
                                    ),
                                  )
                                : model.allItems == null
                                    ? const ErrorOccurredWidget()
                                    : model.allItems.isEmpty
                                        ? const Center(
                                            child: CustomText(
                                              'List is Empty',
                                              fontSize: 16,
                                            ),
                                          )
                                        : Expanded(
                                            child: ListView(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      right: 10),
                                                  child: GridView.builder(
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                              childAspectRatio:
                                                                  1.5,
                                                              mainAxisSpacing:
                                                                  10.0,
                                                              crossAxisSpacing:
                                                                  10.0,
                                                              crossAxisCount:
                                                                  (orientation ==
                                                                          Orientation
                                                                              .portrait)
                                                                      ? 2
                                                                      : 3),
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      itemCount: model.allItems
                                                              ?.length ??
                                                          0,
                                                      itemBuilder:
                                                          (context, index) {
                                                        ItemModel items = model
                                                            .allItems[index];
                                                        return buildCategory(
                                                            context, items, () {
                                                          selected = index;
                                                          print(selected);
                                                          selected == 0
                                                              ? routeTo(context,
                                                                  PubgScreen())
                                                              : selected == 1
                                                                  ? Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              ItuneScreeen()))

                                                                  // routeTo(
                                                                  //     context,
                                                                  //     ItuneScreeen())
                                                                  : selected ==
                                                                          2
                                                                      ? routeTo(
                                                                          context,
                                                                          GooglePlayScreen())
                                                                      : routeTo(
                                                                          context,
                                                                          PlayStationScreen());
                                                          setState(() {});
                                                        });
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                            verticalSpaceMedium,
                            // Wrap(
                            //   // mainAxisAlignment:
                            //   //     MainAxisAlignment.spaceEvenly,
                            //   spacing: 10,
                            //   runSpacing: 10.0,
                            //   children: [
                            //     ProductButton(
                            //       text: 'PUBG',
                            //       onTap: () {
                            //         selected = 0;
                            //         setState(() {});
                            //       },
                            //       color: selected == 0
                            //           ? Styles.colorRed
                            //           : Styles.colorGrey,
                            //     ),
                            //     ProductButton(
                            //       text: 'iTune',
                            //       onTap: () {
                            //         selected = 1;
                            //         setState(() {});
                            //       },
                            //       color: selected == 1
                            //           ? Styles.colorRed
                            //           : Styles.colorGrey,
                            //     ),
                            //     ProductButton(
                            //       text: 'Google Play',
                            //       onTap: () {
                            //         selected = 2;
                            //         setState(() {});
                            //       },
                            //       color: selected == 2
                            //           ? Styles.colorRed
                            //           : Styles.colorGrey,
                            //     ),
                            //     ProductButton(
                            //       text: 'PlayStation',
                            //       onTap: () {
                            //         selected = 3;
                            //         setState(() {});
                            //       },
                            //       color: selected == 3
                            //           ? Styles.colorRed
                            //           : Styles.colorGrey,
                            //     ),
                            //   ],
                            // ),
                            // Expanded(
                            //     child: Container(
                            //   color: Styles.colorGrey.withOpacity(0.1),
                            //   child: selected == 0
                            //       ? PubgContainer()
                            //       : selected == 1
                            //           ? ItuneContainer()
                            //           : selected == 2
                            //               ? GooglePlayContainer()
                            //               : PlayStationContainer(),
                            // )),
                          ],
                        ),
                      ));
            }),
      ),
    );
  }

  // Widget buildAppBar(BuildContext context) {
  //   return AppBar(
  //     backwardsCompatibility: true,
  //     iconTheme: IconThemeData(color: Styles.colorBlack),
  //     elevation: 0,
  //     actions: <Widget>[
  //       Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           InkWell(
  //             onTap: () => routeTo(context, const BagScreen(fromCart: true)),
  //             child: Container(
  //                 padding: EdgeInsets.symmetric(
  //                     vertical: screenAwareSize(5, context),
  //                     horizontal: screenAwareSize(8, context)),
  //                 decoration: BoxDecoration(
  //                     borderRadius:
  //                         BorderRadius.circular(screenAwareSize(8, context)),
  //                     color: Styles.colorPurpleLight),
  //                 child: Row(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     Icon(
  //                       Icons.shopping_bag_outlined,
  //                       color: Styles.colorWhite,
  //                       size: screenAwareSize(22, context),
  //                     ),
  //                     ValueListenableBuilder<int>(
  //                         valueListenable: cartCount,
  //                         builder: (_, int value, __) {
  //                           return CustomText(
  //                             value.toString(),
  //                             fontWeight: FontWeight.bold,
  //                             fontSize: 14,
  //                             color: Styles.colorWhite,
  //                             leftMargin: 8,
  //                           );
  //                         })
  //                   ],
  //                 )),
  //           ),
  //         ],
  //       ),
  //       horizontalSpaceSmall
  //     ],
  //   );
  // }

  Widget homeItems(ItemModel item, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(screenAwareSize(8, context)),
        decoration: BoxDecoration(
            color: Styles.colorWhite,
            boxShadow: <BoxShadow>[
              BoxShadow(color: Styles.colorGreyLight, blurRadius: 4)
            ],
            borderRadius: BorderRadius.circular(
              screenAwareSize(8, context),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(screenAwareSize(8, context)),
                child: CachedNetworkImage(
                  imageUrl: '${item.image}',
                  height: screenAwareSize(200, context),
                  width: screenAwareSize(200, context),
                  fit: BoxFit.fitWidth,
                  placeholder: (context, url) => Utils.progress(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ), //  fit: BoxFit.fitWidth,
              ),
            ),
            verticalSpaceTiny,
            CustomText('${item.categoryNname}',
                centerText: true,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Styles.appBackground1),
          ],
        ),
      ),
    );
  }

  InkWell buildCategory(BuildContext context, ItemModel items, onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(left: 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(screenAwareSize(8, context)),
          child: CachedNetworkImage(
            imageUrl: '${items.image}',
            fit: BoxFit.fill,
            width: 100,
            placeholder: (context, url) => Utils.progress(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  final List _images = [
    'images/shada.png',
    'images/playstation.png',
  ];
}

class ProductButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final color;
  const ProductButton({Key key, this.text, this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: CustomText(
          '$text',
          letterSpacing: 2.0,
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Styles.colorWhite,
        ),
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backwardsCompatibility: true,
      iconTheme: IconThemeData(color: Styles.colorBlack),
      elevation: 0,
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
    );
  }
}
