part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthEventLogin extends AuthEvent {
  final Account account;
  const AuthEventLogin({required this.account});

  @override
  List<Object?> get props => [account];
}

class AuthEventRegister extends AuthEvent {
  final Account account;
  final Profile profile;
  const AuthEventRegister({required this.account, required this.profile});

  @override
  List<Object?> get props => [account, profile];
}

class AuthEventLogout extends AuthEvent {
  const AuthEventLogout();

  @override
  List<Object?> get props => [];
}

class AuthEventValidateToken extends AuthEvent {
  const AuthEventValidateToken();

  @override
  List<Object?> get props => [];
}

class AuthEventSendOTP extends AuthEvent {
  final String email;
  const AuthEventSendOTP({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthEventChangePassword extends AuthEvent {
  final String confirmPassword;
  final String password;
  final String otp;
  const AuthEventChangePassword({required this.confirmPassword, required this.password, required this.otp});

  @override
  List<Object?> get props => [confirmPassword, password, otp];
}