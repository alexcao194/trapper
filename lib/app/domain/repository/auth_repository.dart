import 'package:dartz/dartz.dart';
import 'package:trapper/core/failure/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(String email, String password);
  Future<Either<Failure, void>> register(String email, String password);
  Future<Either<Failure, void>> logout();
}