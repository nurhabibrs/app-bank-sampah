import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio = Dio();

  Future getUserProfileData(String token) async {
    try {
      Response response = await _dio.get(
        'https://345d-103-23-224-196.ap.ngrok.io/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            Headers.contentTypeHeader: 'application/json'
          },
        ),
      );
      return response.data;
    } on DioError catch (err) {
      dynamic errorMessage = err.response?.data;
      return errorMessage;
    }
  }

  Future getAllUserData(String token) async {
    try {
      Response response = await _dio.get(
        'https://345d-103-23-224-196.ap.ngrok.io/admin/profile/get/all',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            Headers.contentTypeHeader: 'application/json'
          },
        ),
      );
      return response.data;
    } on DioError catch (err) {
      dynamic errorMessage = err.response?.data;
      return errorMessage;
    }
  }

  Future searchUserData(String token, username) async {
    try {
      Response response = await _dio.get(
        'https://345d-103-23-224-196.ap.ngrok.io/admin/profile/get/$username',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            Headers.contentTypeHeader: 'application/json'
          },
        ),
      );
      return response.data;
    } on DioError catch (err) {
      dynamic errorMessage = err.response?.data;
      return errorMessage;
    }
  }

  // Future<dynamic> updateUserProfile({
  //   required String token,
  //   required Map<String, dynamic> data,
  // }) async {
  //   try {
  //     Response response = await _dio.put(
  //       'https://api.loginradius.com/identity/v2/auth/account',
  //       data: data,
  //       options: Options(
  //         headers: {'Authorization': 'Bearer $token'},
  //       ),
  //     );
  //     return response.data;
  //   } on DioError catch (e) {
  //     return e.response!.data;
  //   }
  // }

  Future logout(String token) async {
    try {
      Response response = await _dio.get(
        'https://345d-103-23-224-196.ap.ngrok.io/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            Headers.contentTypeHeader: 'application/json',
          },
        ),
      );
      return response.data;
    } on DioError catch (err) {
      dynamic errorMessage = err.response?.data;
      return errorMessage;
    }
  }
}
