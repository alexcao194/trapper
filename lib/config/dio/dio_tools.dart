import 'package:dio/dio.dart';
class DioTools {
  static String get baseUrl {
    return 'https://trapper-server.onrender.com';
  }

  static Dio get dio {
    Dio dio = Dio(
      BaseOptions(
        validateStatus: (status) {
          return status! < 500;
        },
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Connection': 'keep-alive',
        },
      )
    );
    return dio;
  }
}