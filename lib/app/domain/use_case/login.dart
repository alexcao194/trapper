import 'package:trapper/app/domain/entity/account.dart';

import '../../../core/failure/failure.dart';
import '../repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Login {
  final AuthRepository _authRepository;
  const Login({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Either<Failure, void>> call(Account account) {
    return _authRepository.login(account);
  }
}