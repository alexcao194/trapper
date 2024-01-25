import 'package:dartz/dartz.dart';
import 'package:trapper/app/domain/entity/account.dart';
import 'package:trapper/app/domain/entity/profile.dart';
import 'package:trapper/core/failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(Account account);
  Future<Either<Failure, void>> register(Account account, Profile profile);
  Future<Either<Failure, void>> logout();
}