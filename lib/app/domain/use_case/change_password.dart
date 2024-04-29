import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../repository/auth_repository.dart';

class ChangePassword {
  final AuthRepository _authRepository;

  ChangePassword({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Either<Failure, void>> call({required String email, required String otp, required String password}) async {
    return _authRepository.changePassword(email: email, otp: otp, password: password);
  }
}