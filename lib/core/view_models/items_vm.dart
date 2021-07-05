import 'package:flutter/material.dart';
import 'package:q8uc/core/api/actionService.dart';
import 'package:q8uc/core/api/items_api.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/utils/auth_exception.dart';
import 'package:q8uc/utils/custom_exception.dart';

import '../../locator.dart';
import 'base_vm.dart';

class ItemsViewModel extends BaseModel {
  final ItemsApi _itemsApi = locator<ItemsApi>();

  String error;

  //get all items
  List<ItemModel> allItems;

  ActionService actionService;

  Future<void> getAllProduct() async {
    setBusy(true);
    try {
      allItems = await _itemsApi.getAllProduct();
      setBusy(false);
    } on AuthException catch (e) {
      setBusy(false);
      await dialog.showDialog(
          title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
    }
  }

  Future<void> getDetailProduct() async {
    try {
      allItems = await _itemsApi.getAllProduct();
      setBusy(false);
    } on AuthException catch (e) {
      setBusy(false);
      await dialog.showDialog(
          title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
    }
  }

  Future<void> getCartProduct() async {
    try {
      allItems = await _itemsApi.getAllProduct();
      setBusy(false);
    } on AuthException catch (e) {
      setBusy(false);
      await dialog.showDialog(
          title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
    }
  }

  Future<void> getProductCategories() async {
    setBusy(true);
    try {
      allItems = await _itemsApi.getProductCategories();
      setBusy(false);
    } on AuthException catch (e) {
      setBusy(false);
      await dialog.showDialog(
          title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
    }
  }

  Future<void> getItuneCategories() async {
    setBusy(true);
    try {
      allItems = await _itemsApi.getItuneCategories();
      setBusy(false);
    } on AuthException catch (e) {
      setBusy(false);
      await dialog.showDialog(
          title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
    }
  }

  Future<void> getPubGCategories() async {
    setBusy(true);
    try {
      allItems = await _itemsApi.getPubGCategories();
      setBusy(false);
    } on AuthException catch (e) {
      setBusy(false);
      await dialog.showDialog(
          title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
    }
  }

  Future<void> getGooglePlayCategories() async {
    setBusy(true);
    try {
      allItems = await _itemsApi.getGooglePlayCategories();
      setBusy(false);
    } on AuthException catch (e) {
      setBusy(false);
      await dialog.showDialog(
          title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
    }
  }

  Future<void> getPlayStationCategories() async {
    setBusy(true);
    try {
      allItems = await _itemsApi.getPlayStationCategories();
      setBusy(false);
    } on AuthException catch (e) {
      setBusy(false);
      await dialog.showDialog(
          title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
    }
  }


  Future<void> searchItem(String text) async {
    setBusy(true);
    try {
      allItems = await _itemsApi.searchAllItems(text);
      setBusy(false);
      notifyListeners();
    } on CustomException catch (e) {
      setBusy(false);
      await dialog.showDialog(
          title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
    }
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
}
