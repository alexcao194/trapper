import 'dart:async';

import 'package:dio/dio.dart';
import 'package:trapper/di.dart';

import '../../app/data/data_source/local_data.dart';
class DioTools {
  static String get baseUrl {
    // return 'http://localhost:1904';
    return 'https://trapper-server.onrender.com';
  }

  static Dio get dio {
    Dio dio = Dio(
      BaseOptions(
        validateStatus: (status) => status! < 500,
        baseUrl: baseUrl,
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Connection': 'keep-alive',
          'Access-Control-Allow-Origin': '*',
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
        if (response.statusCode == 403) {
          Map<String, String>? newToken = await refreshToken();
          if (newToken == null) {
            return handler.reject(DioException(requestOptions: response.requestOptions, response: response));
          }
          DependencyInjection.sl<LocalData>().saveToken(newToken['access_token']!);
          DependencyInjection.sl<LocalData>().saveRefreshToken(newToken['refresh_token']!);
          response.requestOptions.headers['access_token'] = newToken['access_token'];
          return handler.resolve(await dio.fetch(response.requestOptions));
        }
        return handler.next(response); // continue
      },
      onError: (DioException e, handler) {
        streamController.add(false);
        return handler.next(e); //continue
      }
    ));
    return stream;
  }

  static Future<Map<String, String>?> refreshToken() async {
    String refreshToken = DependencyInjection.sl<LocalData>().getRefreshToken();
    var response = await dio.get(
      '/auth/refresh_token',
      options: Options(headers: {
        'refresh_token': refreshToken
      })
    );
    if (response.statusCode == 200) {
      return {
        'access_token': response.data['access_token'],
        'refresh_token': response.data['refresh_token']
      };
    }
    return null;
  }
}