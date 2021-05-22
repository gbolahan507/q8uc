import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/ui/drawer/pubg_drawer.dart';
import 'package:q8uc/widget/dropdown/itune_dropdown.dart';
import 'package:q8uc/widget/export.dart';

class PubgWards extends StatelessWidget {
  final List _images = [
    'images/uc.jpeg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                  CustomIcon(
                    icon: Icons.shopping_cart,
                    color: Styles.colorBlack,
                    size: 25,
                    onPressed: () {
                      // PubgDrawer();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => CartScreen()));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
        drawer: PubgDrawer(),
        body: Container(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  verticalSpaceMedium,
                  CarouselSlider.builder(
                      itemCount: _images.length,
                      itemBuilder: (BuildContext context, int, itemIndex) =>
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
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                      )),
                  verticalSpaceMedium,
                  ItuneDropDown(),
                  verticalSpaceSmall,
                  Container(
                    // color: Styles.red,
                    child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 1 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: 10,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                              decoration: BoxDecoration(
                                // color: Styles.colorLightBlue,
                                boxShadow: const <BoxShadow>[
                                  BoxShadow(
                                    offset: Offset(1, 1),
                                    color: Colors.black12,
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    // color: Styles.red,
                                    height: screenAwareSize(200, context),
                                    width: screenAwareSize(150, context,
                                        width: true),
                                    child: Image.asset('images/image3.jpg',
                                        fit: BoxFit.cover),
                                  ),
                                  verticalSpaceTiny,
                                  CustomText('PUBG  WARDS', fontSize: 12),
                                  CustomText('Price 24,300 ',
                                      topMargin: 10, fontSize: 14),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomText('270.85 ',
                                            topMargin: 10,
                                            fontSize: 14,
                                            color: Styles.colorBlack),
                                        horizontalSpaceTiny,
                                        CustomText('300.85 ',
                                            decoration:
                                                TextDecoration.lineThrough,
                                            topMargin: 10,
                                            fontSize: 16,
                                            color: Styles.colorBlack),
                                      ]),
                                  verticalSpaceSmall,
                                  verticalSpaceTiny,
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 25),
                                    child: CustomButton(
                                      title: 'ADD TO CART',
                                      fontSize: 12,
                                      height: 40,
                                    ),
                                  )
                                ],
                              ));
                        }),
                  ),
                ],
              ),
            ),
          ],
        )));
  }
}
