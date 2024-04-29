import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../repository/auth_repository.dart';

class SendOTP {
  final AuthRepository _authRepository;

  SendOTP({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Either<Failure, void>> call(String email) {
    return _authRepository.sendOTP(email);
  }
}