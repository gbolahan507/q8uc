import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:q8uc/core/model/error_model.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/model/coupon_model.dart';
import 'package:q8uc/ui/constants/messages.dart';
import 'package:q8uc/utils/custom_exception.dart';
import 'package:q8uc/utils/error_util.dart';
import 'package:q8uc/core/api/base_api.dart';

class SerialApi extends BaseAPI {
  Logger log = Logger();
  bool ret = false;

  Future<bool> checkSerialNumber(
    String productId,
  ) async {
    var formData = FormData();
    formData.fields.addAll([
      MapEntry("product_id", productId),
    ]);

    try {
      var response = await Dio().post(
        "$baseUrl/check_serial_number_availability.php/",
        data: formData,
        options: defaultOptions,
      );
      // log.d(response.data);
      switch (response.data["status"]) {
        case SERVER_OKAY:
          ret = true;
          // return ItemModel.fromJson(response.data);
          break;
        case WRONG_SERVER:
          ret = false;
          throw NO_SERIAL;
          break;
        case SERVER_ERROR:
          try {
            ret = false;
          } catch (e) {
            throw EMPTY_FIELD;
          }
          break;

        default:
          throw ErrorModel.fromJson(response.data).message;
      }
    } catch (e) {
      throw CustomException(DioErrorUtil.handleError(e));
    }
    return ret;
  }

  SerialResponse serialResponse;

  Future<SerialResponse> checkOut(
    String productId,
    String customerId,
  ) async {
    var formData = FormData();
    formData.fields.addAll([
      MapEntry("product_id", productId),
      MapEntry("customer_id", customerId),
    ]);

    try {
      final Response<Map<String, dynamic>> response =
          await Dio().post<Map<String, dynamic>>(
        "$baseUrl/assign_serial_number_to_user_v2.php/",
        data: formData,
        options: defaultOptions,
      );
      log.d(response.data);
      switch (response.data["status"]) {
        case SERVER_OKAY:
          ret = true;
          return SerialResponse.fromJson(response.data);
          break;
        case WRONG_SERVER:
          throw NO_SERIAL;
          break;
        case SERVER_ERROR:
          throw EMPTY_FIELD;
          break;
        default:
          throw ErrorModel.fromJson(response.data);
      }
    } catch (e) {}
  }

  Future<SerialResponse> getOrderHistory(
    String customerId,
  ) async {
    var formData = FormData();
    formData.fields.addAll([
      MapEntry("customer_id", customerId),
    ]);

    try {
      final Response response = await Dio().post(
        "$baseUrl/get_customer_order_history.php",
        data: formData,
        options: defaultOptions,
      );

      switch (response.data["status"]) {
        case SERVER_OKAY:
          return SerialResponse.fromJson(response.data);
          break;
        case WRONG_SERVER:
          throw NO_SERIAL;
          break;
        case SERVER_ERROR:
          throw EMPTY_FIELD;
          break;
        default:
          throw ErrorModel.fromJson(response.data);
      }
    } catch (e) {
      // throw  CustomException(DioErrorUtil.handleError(e));
    }
  }

  Future<SerialResponse> deleteProduct(
    String serialNumber,
  ) async {
    var formData = FormData();
    formData.fields.addAll([
      MapEntry("serial_no", serialNumber),
    ]);

    try {
      final Response response = await Dio().post(
        "$baseUrl/delete_an_order.php",
        data: formData,
        options: defaultOptions,
      );
      print(response.data);
      switch (response.data["status"]) {
        case SERVER_OKAY:
          return SerialResponse.fromJson(response.data);
          break;
        case WRONG_SERVER:
          break;
        case SERVER_ERROR:
          throw EMPTY_FIELD;
          break;
        default:
          throw ErrorModel.fromJson(response.data);
      }
    } catch (e) {
      // throw  CustomException(DioErrorUtil.handleError(e));
    }
  }



  CouponModel couponModel;

  Future<CouponModel> checkCoupon2(
    String couponcode,
  ) async {
    var formData = FormData();
    formData.fields.addAll([
      MapEntry("coupon_code", couponcode),
    ]);

    try {
      final couponModel = await Dio().post(
        "$baseUrl/check_coupon_code_status.php",
        data: formData,
        options: defaultOptions,
      );
      print(couponModel.data);
      if (couponModel.data["status"] == 200) {
        print('good');
      } else {
        print('bad');
      }
      return CouponModel.fromJson(couponModel.data);
    } catch (e) {}
    return couponModel;
  }

}
