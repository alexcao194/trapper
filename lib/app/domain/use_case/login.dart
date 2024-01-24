import '../../../core/failure/failure.dart';
import '../repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class Login {
  final AuthRepository _authRepository;
  const Login({required AuthRepository authRepository}) : _authRepository = authRepository;

  Future<Either<Failure, void>> call(String email, String password) async {
    return await _authRepository.login(email, password);
  }
}