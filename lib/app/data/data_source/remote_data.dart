import 'package:dio/dio.dart';
import 'package:trapper/app/domain/entity/account.dart';

abstract class RemoteData {
  Future<String> login(Account account);
  Future<void> register(Account account, String password);
  Future<void> logout();
}

class RemoteDataImpl implements RemoteData {
  final Dio dio;
  const RemoteDataImpl({required this.dio});

  @override
  Future<String> login(Account account) {
    throw Exception('Not implemented');
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register(Account account, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}

