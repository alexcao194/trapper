import 'package:dartz/dartz.dart';
import 'package:trapper/core/failure/failure.dart';

import '../repository/auth_repository.dart';

class ValidateToken {
  final AuthRepository _authRepository;

  ValidateToken({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Either<Failure, void>> call() {
    return _authRepository.validateToken();
  }
}
