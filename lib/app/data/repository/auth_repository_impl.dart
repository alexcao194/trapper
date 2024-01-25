import 'package:dartz/dartz.dart';
import 'package:trapper/app/data/data_source/local_data.dart';
import 'package:trapper/app/data/data_source/remote_data.dart';
import 'package:trapper/app/domain/entity/account.dart';

import 'package:trapper/core/failure/failure.dart';

import '../../domain/entity/profile.dart';
import '../../domain/repository/auth_repository.dart';

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
      final token = await _remoteData.login(account);
      await _localData.saveToken(token);
      return const Right(null);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> register(Account account, Profile profile) {
    // TODO: implement register
    throw UnimplementedError();
  }

}