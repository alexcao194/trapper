import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../entity/account.dart';
import '../repository/auth_repository.dart';

class ChangePassword {
  late final AuthRepository _authRepository;

  ChangePassword({required AuthRepository authRepository}) {
    _authRepository = authRepository;
  }

  Future<Either<Failure, void>> call({required Account account, required String newPassword}) async {
    return _authRepository.changePassword(account: account, newPassword: newPassword);
  }
}