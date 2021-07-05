import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/core/view_models/items_vm.dart';
import 'package:q8uc/main.dart';
import 'package:q8uc/ui/screens/categories/googlePlay_category.dart';
import 'package:q8uc/ui/screens/categories/itune_category.dart';
import 'package:q8uc/ui/screens/categories/playStation_category.dart';
import 'package:q8uc/ui/screens/categories/pubG_category.dart';
import 'package:q8uc/ui/screens/drawer/app_drawer.dart';
import 'package:q8uc/ui/screens/item_detail_screen.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/base_view.dart';
import 'package:q8uc/utils/router.dart';
import 'package:q8uc/utils/util.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';
import 'package:q8uc/ui/widgets/error_widget.dart';
import 'bag_screen.dart';




class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({Key key}) : super(key: key);

  @override
  _MainLayoutScreenState createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  final SolidController solidController = SolidController();

  int selected = 0;
  ItemModel item;
  ItemsViewModel model;

  @override
  void initState() {
    model = ItemsViewModel();
    item = ItemModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.colorWhite,
      appBar: buildAppBar(context),
      drawer: AppDrawer(),
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
                  onModelReady: (ItemsViewModel model) => model.getAllProduct(),
                  builder: (_, ItemsViewModel model, __) => Stack(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              CarouselSlider.builder(
                                  itemCount: _images.length,
                                  itemBuilder:
                                      (BuildContext context, int, itemIndex) =>
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
                                    height: 150,
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

                              StreamBuilder<bool>(
                                  stream: solidController.isOpenStream,
                                  initialData: false,
                                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                                    return BaseView<ItemsViewModel>(
                                        onModelReady: (ItemsViewModel model) =>
                                            model.getProductCategories(),
                                        builder: (_, ItemsViewModel model, __) => Stack(
                                              children: <Widget>[
                                                SafeArea(
                                                  child: Column(
                                                    children: <Widget>[
                                                      verticalSpaceMedium,
                                                      model.busy
                                                          ? const Center(
                                                              child: CupertinoActivityIndicator())
                                                          : model.allItems == null
                                                              ? const ErrorOccurredWidget()
                                                              : model.allItems.isEmpty
                                                                  ? const Center(
                                                                      child: CustomText(
                                                                        'List is Empty',
                                                                        fontSize: 16,
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      height: 120,
                                                                      margin: EdgeInsets.all(10),
                                                                      child: ListView.builder(
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          shrinkWrap: true,
                                                                          itemCount: model
                                                                                  .allItems?.length ??
                                                                              0,
                                                                          itemBuilder:
                                                                              (context, index) {
                                                                            ItemModel items =
                                                                                model.allItems[index];
                                                                            return buildCategory(
                                                                                context, items, () {
                                                                              selected = index;
                                                                              print(selected);
                                                                              setState(() {});
                                                                            });
                                                                          }),
                                                                    ),
                                                      CustomText(
                                                        selected == 0
                                                            ? 'PUBG'
                                                            : selected == 1
                                                                ? "iTune"
                                                                : selected == 2
                                                                    ? "Google Play"
                                                                    : "PlayStation",
                                                        letterSpacing: 2.0,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                        color: Styles.red,
                                                      ),
                                                      Expanded(
                                                          child: Container(
                                                        color: Styles.colorGrey.withOpacity(0.1),
                                                        child: selected == 0
                                                            ? PubgContainer()
                                                            : selected == 1
                                                                ? ItuneContainer()
                                                                : selected == 2
                                                                    ? GooglePlayContainer()
                                                                    : PlayStationContainer(),
                                                      )),
                                                      // SizedBox(height: screenAwareSize(50, context))
                                                    ],
                                                  ),
                                                ),
                                                if (snapshot.data)
                                                  Container(
                                                    height: screenHeight(context),
                                                    width: screenWidth(context),
                                                    color: Colors.black45,
                                                  )
                                              ],
                                            ));
                                  }),

                              // Expanded(
                              //   child: Padding(
                              //     padding: EdgeInsets.all(
                              //         screenAwareSize(12, context)),
                              //     child: model.busy
                              //         ? const Center(
                              //             child: CupertinoActivityIndicator())
                              //         : model.allItems == null
                              //             ? const ErrorOccurredWidget()
                              //             : model.allItems.isEmpty
                              //                 ? const Center(
                              //                     child: CustomText(
                              //                       'List is Empty',
                              //                       fontSize: 16,
                              //                     ),
                              //                   )
                              //                 : StaggeredGridView.count(
                              //                     shrinkWrap: true,
                              //                     crossAxisCount: 4,
                              //                     children: model.allItems
                              //                         .map<Widget>(
                              //                             (ItemModel item) {
                              //                       return homeItems(item);
                              //                     }).toList(),
                              //                     staggeredTiles: model.allItems
                              //                         .map<StaggeredTile>((_) =>
                              //                             const StaggeredTile
                              //                                 .fit(2))
                              //                         .toList(),
                              //                     mainAxisSpacing:
                              //                         screenAwareSize(
                              //                             12, context),
                              //                     crossAxisSpacing:
                              //                         screenAwareSize(
                              //                             12, context)),
                              //   ),
                              // ),
                              // SizedBox(height: screenAwareSize(50, context))
                            ],
                          ),
                          if (snapshot.data)
                            Container(
                              height: screenHeight(context),
                              width: screenWidth(context),
                              color: Colors.black45,
                            )
                        ],
                      ));
            }),
      ),
    );
  }

  Widget homeItems(ItemModel item) {
    return GestureDetector(
      onTap: () {
        Utils.offKeyboard(context);
        routeTo(context, ItemDetailScreen(item: item));
      },
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
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Utils.progress(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            CustomText('${item.name}',
                centerText: true,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Styles.colorBlack),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: screenAwareSize(4, context),
                    horizontal: screenAwareSize(12, context)),
                decoration: BoxDecoration(
                    color: Styles.colorGrey,
                    borderRadius:
                        BorderRadius.circular(screenAwareSize(16, context))),
                child: CustomText('\$${item.price}',
                    centerText: true,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Styles.colorWhite),
              ),
            ),
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
            width: 120,
            placeholder: (context, url) => Utils.progress(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backwardsCompatibility: true,
      iconTheme: IconThemeData(color: Styles.colorBlack),
      elevation: 0,
      title: Row(
        children: [
          CustomText(
            'Hello,',
            fontSize: 14,
            color: Styles.colorBlack,
          ),
          horizontalSpaceTiny,
          CustomText(
            '${AppCache.getUser().username}',
            fontSize: 16,
            color: Styles.appBackground1,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
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

  final List _images = [
    'images/shada.png',
    'images/playstation.png',
  ];
}
