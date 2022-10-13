import 'package:dio/dio.dart';

import 'api_service.dart';

class AuthService {
  static login(data) async {
    try {
      Response response =
          await ApiService.getApiHandler('').post("user/io-login", data: data);
      return response.data;
    } on DioError catch (error) {
      error.response!.data['errors'];
    }
  }

  static register(data) async {
    try {
      Response response = await ApiService.getApiHandler('')
          .post('user/io-register', data: data);

      if (response.statusCode == 500) {
        return response.statusCode;
      }
      return response.data;
    } on DioError catch (error) {
      error.response!.data['errors'];
    }
  }
}
