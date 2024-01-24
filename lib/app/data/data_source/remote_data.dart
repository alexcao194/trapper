import 'package:dio/dio.dart';

abstract class RemoteData {
  Future<void> login(String email, String password);
  Future<void> register(String email, String password);
  Future<void> logout();
}

class RemoteDataImpl implements RemoteData {
  final Dio dio;
  const RemoteDataImpl({required this.dio});
  @override
  Future<void> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}

