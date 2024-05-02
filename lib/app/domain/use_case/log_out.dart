import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../repository/auth_repository.dart';

class Logout {
  final AuthRepository _authRepository;

  Logout({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future<Either<Failure, void>> call() {
    return _authRepository.logout();
  }
}