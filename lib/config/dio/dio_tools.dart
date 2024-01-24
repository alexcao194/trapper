import 'package:dio/dio.dart';
class DioTools {
  static String get baseUrl {
    return 'https://trapper-api.herokuapp.com/api/v1';
  }

  static Dio get dio {
    Dio dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      )
    );
    dio.options.baseUrl = baseUrl;
    return dio;
  }
}