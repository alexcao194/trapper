import 'package:dartz/dartz.dart';
import 'package:trapper/app/domain/entity/account.dart';
import 'package:trapper/app/domain/entity/profile.dart';
import 'package:trapper/core/failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(Account account);
  Future<Either<Failure, void>> register(Account account, Profile profile);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, void>> validateToken();
  Future<Either<Failure, void>> sendOTP(String email);
  Future<Either<Failure, void>> changePassword({required String email, required String otp, required String password});
}