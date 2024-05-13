import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:trapper/config/socket/app_socket.dart';
import 'package:trapper/di.dart';

import '../../app/data/data_source/local_data.dart';
class DioTools {
  static late String _baseUrl;
  static late Dio _dio;
  static String get baseUrl => _baseUrl;
  static Dio get dio => _dio;

  static void init() {
    _baseUrl = _getUrl();
    debugPrint('BASE_URL: $_baseUrl');
    _dio = Dio(
        BaseOptions(
          validateStatus: (status) => status! < 500,
          baseUrl: _baseUrl,
          headers: {
            'Content-Type': 'application/json',
          },
        )
    );
  }

  static Stream<bool> registerInterceptors(Dio dio) {
    StreamController<bool> streamController = StreamController<bool>();
    Stream<bool> stream = streamController.stream;
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['access_token'] = DependencyInjection.sl<LocalData>().getToken();
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        if (response.statusCode == 401) {
          Map<String, String>? newToken = await refreshToken();
          if (newToken == null) {
            return handler.resolve(response);
          }
          AppSocket.init(newToken['access_token']!);
          DependencyInjection.sl<LocalData>().saveToken(newToken['access_token']!);
          DependencyInjection.sl<LocalData>().saveRefreshToken(newToken['refresh_token']!);
          response.requestOptions.headers['access_token'] = newToken['access_token'];
          return handler.resolve(await dio.fetch(response.requestOptions));
        }
        debugPrint('Response: ${response.data}');
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
    debugPrint("Access token is expired or not found.");
    if (refreshToken.isEmpty) {
      debugPrint('User is not logged in. No refresh token found.');
      return null;
    }
    debugPrint('Refreshing token...');
    debugPrint('Refresh token: $refreshToken');
    var response = await dio.get(
      '/auth/refresh_token',
      options: Options(headers: {
        'refresh_token': refreshToken
      })
    );
    if (response.statusCode == 200) {
      debugPrint('Token refreshed successfully.');
      return {
        'access_token': response.data['access_token'],
        'refresh_token': response.data['refresh_token']
      };
    }
    debugPrint(response.data);
    return null;
  }

  static String _getUrl() {
    if (kDebugMode && kIsWeb) {
      return 'https://trapper-server.onrender.com';
      return 'http://localhost:1904';
    } else {
      return 'https://trapper-server.onrender.com';
    }
  }
}