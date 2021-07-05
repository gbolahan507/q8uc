import 'package:dio/dio.dart';
import 'package:q8uc/core/api/base_api.dart';
import 'package:logger/logger.dart';

class PaymentApi extends PaymentBaseAPI {
  Future paymentrequest(double invoicevalue) async {
    Map data = {
      "PaymentMethodId": 2,
      "CustomerName": "KOLA",
      "DisplayCurrencyIso": "KWD",
      "CustomerEmail": "kola@gmail.com",
      "NotificationOption": "SMS",
      "MobileCountryCode": "965",
      "CustomerMobile": "12345678",
      "CallBackUrl":
          "https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png",
      "ErrorUrl":
          "https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png",
      'InvoiceValue': invoicevalue
    };

    try {
      var response = await Dio().post(
        baseUrl,
        options: defaultOptions,
        data: data,
      );
      Logger().d(response.statusCode);
      Logger().d(response.data["Message"]);


      if (response.statusCode == 200) {
        print('successful');
        print(response.data['Message']);
        // print(response.data);

      }
      return response;
    } on DioError catch (e) {
      print(e.response);
      print(e.message);
      print(e.response.data);
      print(e.response.extra);
      print(e.response);
      print(e.response.statusCode);
      print(e.response.redirects);
      print(e.error);
      return e.response;
    }
  }
}
