import 'package:trapper/app/domain/entity/account.dart';
import 'package:trapper/app/domain/entity/profile.dart';

import '../../../core/failure/failure.dart';
import '../repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Register {
  final AuthRepository _authRepository;
  const Register({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Either<Failure, void>> call(Account account, Profile profile) {
    return _authRepository.register(account, profile);
  }
}