import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trapper/app/data/data_source/local_data.dart';
import 'package:trapper/app/data/data_source/remote_data.dart';
import 'package:trapper/app/data/model/account_model.dart';
import 'package:trapper/app/domain/entity/account.dart';
import 'package:trapper/config/socket/app_socket.dart';

import 'package:trapper/core/failure/failure.dart';

import '../../domain/entity/profile.dart';
import '../../domain/repository/auth_repository.dart';
import '../model/profile_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LocalData _localData;
  final RemoteData _remoteData;

  const AuthRepositoryImpl({
    required LocalData localData,
    required RemoteData remoteData,
  })  : _localData = localData,
        _remoteData = remoteData;

  @override
  Future<Either<Failure, void>> login(Account account) async {
    try {
      final token = await _remoteData.login(AccountModel.fromEntity(account));
      await _saveTokenAndInitNewSession(token);
      return const Right(null);
    } on DioException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await _remoteData.logout();
      await _localData.deleteToken();
      await _localData.deleteRefreshToken();
      return const Right(null);
    } on DioException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> register(
      Account account, Profile profile) async {
    try {
      final token = await _remoteData.register(
        AccountModel.fromEntity(account),
        ProfileModel.fromEntity(profile),
      );
      await _saveTokenAndInitNewSession(token);
      return const Right(null);
    } on DioException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> validateToken() async {
    try {
      var token = _localData.getToken();
      if (token.isEmpty) {
        return Left(Failure(null));
      }
      await _remoteData.validateToken();
      _saveTokenAndInitNewSession({'access_token': token});
      return const Right(null);
    } on DioException catch (e) {
      return Left(Failure(e.message));
    }
  }

  Future<void> _saveTokenAndInitNewSession(Map<String, String> token) async {
    AppSocket.init(token['access_token']!);
    await _localData.saveToken(token['access_token']!);
    if (token.containsKey('refresh_token')) {
      await _localData.saveRefreshToken(token['refresh_token']!);
    }
  }

  @override
  Future<Either<Failure, void>> changePassword({required String email, required String otp, required String password}) async {
    try {
      await _remoteData.changePassword(email: email, otp: otp, password: password);
      return const Right(null);
    } on DioException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> sendOTP(String email) async {
    try {
      await _remoteData.sendOTP(email);
      return const Right(null);
    } on DioException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
