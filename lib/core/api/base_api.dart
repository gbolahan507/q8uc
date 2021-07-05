import 'package:dio/dio.dart';
import 'package:q8uc/locator.dart';
import 'package:q8uc/ui/constants/messages.dart';
import 'package:q8uc/utils/navigator.dart';

class BaseAPI {
  var dio = Dio();
  String baseUrl = kBaseUrl;
  Options defaultOptions = Options(
      sendTimeout: 20000, // 20 seconds
      receiveTimeout: 20000, // 20 seconds
      contentType: 'multipart/form-data',
      validateStatus: (status) => status < 500);
  NavigationService navigate = locator<NavigationService>();

}

class PaymentBaseAPI {
  var dio = Dio();
  String baseUrl = "https://apitest.myfatoorah.com/v2/ExecutePayment";
  Options defaultOptions = Options(
      contentType: 'application/json',
      headers: {
        'Authorization':
         "Bearer rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL"
      },
      validateStatus: (
        status) => status < 500
        
        );
      }

// Future<Response> postDio(String url, {Map data, token}) async {
//   try {
//     print(
//         'making post http to $url  -- full url $apiUrl$url , data ---- $data');
//     print(DateTime.now().millisecondsSinceEpoch);
//     Dio dio = new Dio();
//     dio.options.headers['Content-Type'] = 'application/json';
//     dio.options.headers["Bearer rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL"] = token;
//     Response response = await dio.post('$apiUrl$url', data: data);

//     print('get response -- $response');
//     return response;
//   } catch (e) {
//     DioError error = e;
//     print(error.response.statusMessage);
//     print('${error.response.statusMessage}');
//     print(error.message);
//     print(error.response.data);
//     print(error.response.extra);
//     print(error.response);
//     print(error.response.statusCode);
//     print(error.response.redirects);
//     print(error.error);
//     return error.response;
//   }
// }
