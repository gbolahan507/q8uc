import 'dart:async';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:q8uc/core/api/base_api.dart';
import 'package:q8uc/core/model/item.dart';

class ItemsApi extends BaseAPI {
  Logger log = Logger();
  String filename = 'allProduct.json';

  bool ret = false;

  Future<List<ItemModel>> getAllProduct() async {
    List<ItemModel> data = <ItemModel>[];
      try {
        var response = await Dio().get(
          '$baseUrl/get_products.php',
          options: defaultOptions,
        );
        if (response.statusCode == 200) {
          data = (response.data as List)
              .map((e) => ItemModel.fromJson(e))
              .toList();
        }
        await Future<void>.delayed(const Duration(seconds: 1));
        // since there's no api to get from, we fetch from a list locally stored
        return data;
      } on DioError catch (e) {
        print(e.response);
      }
      return data;
    // }
  }

  // get product Categories

  Future<List<ItemModel>> getProductCategories() async {
    List<ItemModel> data = <ItemModel>[];
    try {
      // simulate loading/network delay
      var response = await Dio().get(
        '$baseUrl/get_categories.php',
        options: defaultOptions,
      );
      if (response.statusCode == 200) {
        data =
            (response.data as List).map((e) => ItemModel.fromJson(e)).toList();
      }
      await Future<void>.delayed(const Duration(seconds: 1));
      // since there's no api to get from, we fetch from a list locally stored
      return data;
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }

  // get Itune Category

  Future<List<ItemModel>> getItuneCategories() async {
    List<ItemModel> data = <ItemModel>[];
    try {
      // simulate loading/network delay
      var response = await Dio().get(
        '$baseUrl/get_itunes_products.php',
        options: defaultOptions,
      );
      if (response.statusCode == 200) {
        data = (response.data["msg"] as List)
            .map((e) => ItemModel.fromJson(e))
            .toList();
      }
      await Future<void>.delayed(const Duration(seconds: 1));
      // since there's no api to get from, we fetch from a list locally stored
      return data;
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }

  // get pubg Category

  Future<List<ItemModel>> getPubGCategories() async {
    List<ItemModel> data = <ItemModel>[];
    try {
      // simulate loading/network delay
      var response = await Dio().get(
        '$baseUrl/get_pubgmobileuc_products.php',
        options: defaultOptions,
      );
      if (response.statusCode == 200) {
        data = (response.data["msg"] as List)
            .map((e) => ItemModel.fromJson(e))
            .toList();
      }
      await Future<void>.delayed(const Duration(seconds: 1));
      // since there's no api to get from, we fetch from a list locally stored
      return data;
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }

  // get googleplay Category

  Future<List<ItemModel>> getGooglePlayCategories() async {
    List<ItemModel> data = <ItemModel>[];
    try {
      // simulate loading/network delay
      var response = await Dio().get(
        '$baseUrl/get_googleplay_products.php',
        options: defaultOptions,
      );
      if (response.statusCode == 200) {
        data = (response.data["msg"] as List)
            .map((e) => ItemModel.fromJson(e))
            .toList();
      }
      await Future<void>.delayed(const Duration(seconds: 1));
      // since there's no api to get from, we fetch from a list locally stored
      return data;
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }

  // get playstation Category

  Future<List<ItemModel>> getPlayStationCategories() async {
    List<ItemModel> data = <ItemModel>[];
    try {
      // simulate loading/network delay
      var response = await Dio().get(
        '$baseUrl/get_playstation_products',
        options: defaultOptions,
      );
      if (response.statusCode == 200) {
        data = (response.data["msg"] as List)
            .map((e) => ItemModel.fromJson(e))
            .toList();
      }
      await Future<void>.delayed(const Duration(seconds: 1));
      // since there's no api to get from, we fetch from a list locally stored
      return data;
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }

  //  check if serialNumber is available

  Future<List<ItemModel>> searchAllItems(String a) async {
    try {
      final List<ItemModel> list = <ItemModel>[];
      var response = await Dio().get(
        '$baseUrl/get_products.php',
        options: defaultOptions,
      );
      for (final ItemModel val in response.data) {
        if (val.name.contains(a)) {
          list.add(val);
        }
      }
      // simulate loading/network delay
      await Future<void>.delayed(const Duration(milliseconds: 500));
      // since there's no api to get from, we fetch from a list locally stored
      return list;
    } catch (e) {
      throw 'Error';
    }
  }

  //   void searchOperation(String searchText) {
  //   searchresult.clear();
  //   if (_isSearching != null) {
  //     for (int i = 0; i < jobhistory.length; i++) {
  //       JobHistory data = jobhistory[i];
  //       if (data.heartisanName
  //           .toLowerCase()
  //           .contains(searchText.toLowerCase())) {
  //         searchresult.add(data);
  //       }
  //     }
  //   }
  // }
}
