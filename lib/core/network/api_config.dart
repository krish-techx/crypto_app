import 'package:dio/dio.dart';

class ApiConfig {
  static final String _userApi = 'https://api.coingecko.com/api/v3/simple';
  static final int _connectTimeout = 10000;
  static final int _receiveTimeout = 10000;
  static const ResponseType _responseType = ResponseType.json;
  static const String _contentType = 'application/json';

  static final BaseOptions baseOptions = BaseOptions(
    baseUrl: _userApi,
    connectTimeout: Duration(milliseconds: _connectTimeout),
    receiveTimeout: Duration(milliseconds: _receiveTimeout),
    responseType: _responseType,
    contentType: _contentType,
  );
}
