import 'package:dio/dio.dart';
import 'package:q8uc/core/api/base_api.dart';
import 'package:q8uc/core/model/item.dart';

class ActionService extends BaseAPI {
//   Future<CartResponseModel> addtoCart(CartReQuestModel model) async {

//     CartResponseModel responseModel;

//     try{
//       var response = await Dio().post(
//         'url',
//         data: model.toJson(),
//         options: defaultOptions
//       );
//       if(response.statusCode == 200){
//         responseModel = CartResponseModel.fromJson(response.data);

//       }
//     } on DioError catch (e){
//       if(e.response.statusCode !=200){
//       print(e.response.statusCode);
//       } else {
//         print(e.message);
//         print(e.requestOptions);

//       }
//     }
//     return responseModel;
//   }

// Future<CartResponseModel> getCartItem() async {
//  CartResponseModel responseModel;

//  try{
//    var response = await Dio().get(
//      'url',
//      options: defaultOptions,

//    );
//    if(response.statusCode == 200){
//      responseModel = CartResponseModel.fromJson(response.data);
//    }
//  } on DioError catch (e) {
//    print(e.response);
//  }
// return responseModel;
// }

  Future<List<ItemModel>> getProductCategories() async {
    List<ItemModel> data = <ItemModel>[];
    try {
      var response = await Dio().get(
        'http://mydealtrackerweb.staging.cloudware.ng/ussd/q8uc_mobile/wpapi/v1/get_products.php',
        options: defaultOptions,
      );
      if (response.statusCode == 200) {
        data =
            (response.data as List).map((e) => ItemModel.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }
}
