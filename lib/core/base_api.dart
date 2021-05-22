import 'package:dio/dio.dart';

class BaseAPI {
  var dio = Dio();
  String baseUrl = "http://157.175.86.25/wp-admin/wpapi/v1/";
  Options defaultOptions =
      Options(contentType: 'multipart/form-data', validateStatus: (status) => status < 500);
}
