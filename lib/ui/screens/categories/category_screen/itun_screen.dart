import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/view_models/items_vm.dart';
import 'package:q8uc/ui/screens/categories_screen.dart';
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



class ItuneScreeen extends StatelessWidget {
  final SolidController solidController = SolidController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(60), child: MyAppBar()),
      body: StreamBuilder<bool>(
          stream: solidController.isOpenStream,
          initialData: false,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return BaseView<ItemsViewModel>(
                onModelReady: (ItemsViewModel model) =>
                    model.getItuneCategories(),
                builder: (_, ItemsViewModel model, __) => Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(
                                    screenAwareSize(12, context)),
                                child: model.busy
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
                                            : StaggeredGridView.count(
                                                shrinkWrap: true,
                                                crossAxisCount: 4,
                                                children: model.allItems
                                                    .map<Widget>(
                                                        (ItemModel item) {
                                                  return homeItems(
                                                      context, item);
                                                }).toList(),
                                                staggeredTiles: model.allItems
                                                    .map<StaggeredTile>((_) =>
                                                        const StaggeredTile.fit(
                                                            2))
                                                    .toList(),
                                                mainAxisSpacing:
                                                    screenAwareSize(
                                                        12, context),
                                                crossAxisSpacing:
                                                    screenAwareSize(
                                                        12, context)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ));
          }),
    );
  }

  Widget homeItems(
    BuildContext context,
    ItemModel item,
  ) {
    return GestureDetector(
      onTap: () {
        Utils.offKeyboard(context);
        routeTo(context, ItemDetailScreen(item: item));
        print('hello');
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
                child: Container(
                  child: CachedNetworkImage(
                    imageUrl: '${item.image}',
                    fit: BoxFit.fill,
                    placeholder: (context, url) => Utils.progress(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
            verticalSpaceTiny,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomText('${item.name}',
                      centerText: true,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Styles.colorRed),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: CustomText('\$${item.price}',
                  centerText: true,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Styles.colorBlack),
            ),
            verticalSpaceSmall,
          ],
        ),
      ),
    );
  }
}
