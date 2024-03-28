import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalData {
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  Future<String> getToken();
}

class LocalDataImpl implements LocalData {
  final SharedPreferences sharedPreferences;

  static const String tokenKey = 'token';

  LocalDataImpl({required this.sharedPreferences});

  @override
  Future<void> deleteToken() async {
    await sharedPreferences.remove(tokenKey);
  }

  @override
  Future<String> getToken() async {
    return sharedPreferences.getString(tokenKey) ?? '';
  }

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(tokenKey, token);
  }
}