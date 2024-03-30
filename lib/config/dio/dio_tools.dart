import 'dart:async';

import 'package:dio/dio.dart';
import 'package:trapper/di.dart';

import '../../app/data/data_source/local_data.dart';
class DioTools {
  static String get baseUrl {
    return 'https://trapper-server.onrender.com';
  }

  static Dio get dio {
    Dio dio = Dio(
      BaseOptions(
        validateStatus: (status) => status! < 500,
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Connection': 'keep-alive',
        },
      )
    );
    return dio;
  }

  static Stream<bool> registerInterceptors(Dio dio) {
    StreamController<bool> streamController = StreamController<bool>();
    Stream<bool> stream = streamController.stream;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['access_token'] = DependencyInjection.sl<LocalData>().getToken();
        return handler.next(options); //continue
      },
      onResponse: (response, handler) async {
        if (response.statusCode == 401) {
          String? newToken = await refreshToken();
          if (newToken == null) {
            return handler.reject(DioException(requestOptions: response.requestOptions, response: response));
          }
          DependencyInjection.sl<LocalData>().saveToken(newToken);
          response.requestOptions.headers['access_token'] = newToken;
          return handler.resolve(await dio.fetch(response.requestOptions));
        }
        if (response.statusCode == 403) {
          streamController.add(false);
          return handler.reject(DioException(requestOptions: response.requestOptions, response: response));
        }
        return handler.next(response); // continue
      },
      onError: (DioException e, handler) {
        return handler.next(e); //continue
      }
    ));
    return stream;
  }

  static Future<String?> refreshToken() async {
    print('refresh token');
    String refreshToken = DependencyInjection.sl<LocalData>().getRefreshToken();
    var response = await dio.post(
      '/auth/refresh_token',
      data: {
        'refresh_token': refreshToken
      }
    );
    if (response.statusCode == 200) {
      return response.data['access_token'];
    }
    return null;
  }
}