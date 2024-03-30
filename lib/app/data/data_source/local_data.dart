import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  String getToken();

  Future<void> saveRefreshToken(String token);
  Future<void> deleteRefreshToken();
  String getRefreshToken();
}

class LocalDataImpl implements LocalData {
  final SharedPreferences sharedPreferences;

  static const String tokenKey = 'token';
  static const String refreshTokenKey = 'refreshToken';

  LocalDataImpl({required this.sharedPreferences});

  @override
  Future<void> deleteToken() async {
    await sharedPreferences.remove(tokenKey);
  }

  @override
  String getToken() {
    return sharedPreferences.getString(tokenKey) ?? '';
  }

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(tokenKey, token);
  }

  @override
  Future<void> deleteRefreshToken() async {
    await sharedPreferences.remove(refreshTokenKey);
  }

  @override
  String getRefreshToken() {
    return sharedPreferences.getString(refreshTokenKey) ?? '';
  }

  @override
  Future<void> saveRefreshToken(String token) {
    return sharedPreferences.setString(refreshTokenKey, token);
  }
}