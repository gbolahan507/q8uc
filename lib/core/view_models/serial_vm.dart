import 'package:q8uc/core/api/get_serial.dart';
import 'package:q8uc/core/model/item.dart';
import 'package:q8uc/core/model/coupon_model.dart';
import 'package:q8uc/core/model/serial_model.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/core/view_models/base_vm.dart';
import 'package:q8uc/locator.dart';
import 'package:q8uc/utils/custom_exception.dart';

class SerialViewModel extends BaseModel {
  final SerialApi _serialApi = locator<SerialApi>();

  List<SerialResponse> allHistory;

  String error1;
  String error2;
  String error3;

  Future checkSerialNumber(String productId) async {
    setBusy(true);
    try {
      await _serialApi.checkSerialNumber(productId).then((ret) {
        if (ret) {}
      });
      setBusy(false);
      notifyListeners();
    } on CustomException catch (e) {
      error2 = e.message;
      setBusy(false);
      await dialog.showDialog(
          title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
      print(e.message);
    }
  }

  SerialResponse serialResponse;

  Future<void> checkOut(String productId, customerId) async {
    setBusy(true);
    try {
      await _serialApi.checkOut(productId, customerId);
      setBusy(false);
      notifyListeners();
    } on CustomException catch (e) {
      error2 = e.message;
      setBusy(false);
      // await dialog.showDialog(
      //     title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
      print(e.message);
    }
  }

  Future<List<Datum>> getOrderHistory(String customerId) async {
    setBusy(true);
    try {
      await _serialApi.getOrderHistory(customerId);
      setBusy(false);
      notifyListeners();
    } on CustomException catch (e) {
      error2 = e.message;
      setBusy(false);
      // await dialog.showDialog(
      //     title: 'Error!', description: e.message, buttonTitle: 'Close');
      notifyListeners();
      print(e.message);
    }
    return null;
  }

  CouponModel couponModel;

  Future<CouponModel> checkCoupon2(String coupon) async {
    setBusy(true);
    try {
      couponModel = await _serialApi.checkCoupon2(coupon);
      AppCache.saveCoupon(couponModel);
      setBusy(false);
      notifyListeners();
      return couponModel;
    } on CustomException catch (e) {
      error2 = e.message;
      setBusy(false);
      showErrorDialog(e);
      notifyListeners();
      return couponModel;
    }
  }

  void showErrorDialog(CustomException e) {
    dialog.showDialog(
        title: 'Error', description: e.message, buttonTitle: 'Close');
  }
}
