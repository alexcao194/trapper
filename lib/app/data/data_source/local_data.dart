import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  Future<String> getToken();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> deleteToken() async {
    await sharedPreferences.remove('token');
  }

  @override
  Future<String> getToken() async {
    return sharedPreferences.getString('token') ?? '';
  }

  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString('token', token);
  }
}