


import 'package:dio/dio.dart';
import 'package:q8uc/core/base_api.dart';
import 'package:q8uc/model/cart_request_model.dart';
import 'package:q8uc/model/cart_response_model.dart';
import 'package:q8uc/model/categories.dart';

class ActionService extends BaseAPI {


  Future<CartResponseModel> addtoCart(CartReQuestModel model) async {

    CartResponseModel responseModel;

    try{
      var response = await Dio().post(
        'url',
        data: model.toJson(),
        options: defaultOptions
      );
      if(response.statusCode == 200){
        responseModel = CartResponseModel.fromJson(response.data);
        

      }
    } on DioError catch (e){
      if(e.response.statusCode !=200){
      print(e.response.statusCode);
      } else {
        print(e.message);
        print(e.requestOptions);

      }
    } 
    return responseModel;
  }


Future<CartResponseModel> getCartItem() async {
 CartResponseModel responseModel;

 try{
   var response = await Dio().get(
     'url',
     options: defaultOptions,

   );
   if(response.statusCode == 200){
     responseModel = CartResponseModel.fromJson(response.data);
   }
 } on DioError catch (e) {
   print(e.response);
 }
return responseModel;
}


Future<List<Categories>> getProductCategories() async {
  List<Categories> data = List<Categories>();
 try{
   var response = await Dio().get(
     'url',
     options: defaultOptions,

   );
   if(response.statusCode == 200){
   }
 } on DioError catch (e) {
   print(e.response);
 }
return data;

}

}