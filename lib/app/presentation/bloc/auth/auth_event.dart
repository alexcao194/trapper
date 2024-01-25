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