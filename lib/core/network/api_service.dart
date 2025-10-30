import 'dart:developer';

import 'package:crypto_app/core/network/api_config.dart';
import 'package:crypto_app/core/network/request_type.dart';
import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio(ApiConfig.baseOptions);

  // region Singleton
  static final ApiService instance = ApiService._internal();

  factory ApiService() => instance;

  ApiService._internal();
  // endregion

  Future<Map<String, dynamic>> getPrice({
    String? coinId,
    String currency = 'usd',
  }) async {
    final Map<String, dynamic> parameters = {
      'ids': coinId,
      'vs_currencies': currency,
      'include_last_updated_at': true,
    };

    final response = await _makeApiCall(path: '/price', parameters: parameters);

    if (response.statusCode == 200) {
      final data = response.data ?? {};
      return data;
    } else {
      throw Exception('Failed to fetch price');
    }
  }

  Future<Response> _makeApiCall({
    String path = '',
    Map<String, dynamic>? parameters = const {},
    RequestType requestType = RequestType.get,
  }) async {
    try {
      final response = await _dio.request(
        path,
        queryParameters: parameters,
        options: Options(
          followRedirects: false,
          method: _getRequestMethod(requestType),
        ),
      );
      log('api-res: $response');

      return response;
    } on DioException catch (e) {
      final message = e.response?.data?['status']?['error_message'];

      if (message != null) {
        throw '$message';
      } else {
        throw _handleDioError(e);
      }
    }
  }

  String _getRequestMethod(RequestType requestType) {
    switch (requestType) {
      case RequestType.get:
        return 'GET';
      case RequestType.post:
        return 'POST';
    }
  }

  String _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
        return 'No Internet Connection';
      case DioExceptionType.receiveTimeout:
        return 'Server Timeout';
      case DioExceptionType.badResponse:
        return 'Server returned invalid response';
      default:
        return e.message ?? 'Something went wrong';
    }
  }
}
