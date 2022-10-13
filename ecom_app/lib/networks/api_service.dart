import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiService {
  static Dio getApiHandler(String token, {bool isFormData = false}) {
    BaseOptions options = BaseOptions(
      baseUrl: "http://192.168.99.108:3000/api/v1/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    if (token != '') options.headers["Authorization"] = "Bearer $token";

    options.headers["Accept"] = "application/json";
    isFormData ? options.headers['Content-Type'] = 'multipart/form-data' : null;

    Dio dio = Dio(options);
    dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        compact: false,
      )
    ]);

    return dio;
  }
}
