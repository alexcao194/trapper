part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();

  @override
  List<Object?> get props => [];
}

class AuthStateAuthenticated extends AuthState {
  const AuthStateAuthenticated();

  @override
  List<Object?> get props => [];
}

class AuthStateUnauthenticated extends AuthState {
  const AuthStateUnauthenticated();

  @override
  List<Object?> get props => [];
}

class AuthStateFailure extends AuthState {
  final String? error;
  const AuthStateFailure({required this.error});

  @override
  List<Object?> get props => [error];
}

class AuthStateForgotPassword extends AuthState {
  const AuthStateForgotPassword();

  @override
  List<Object?> get props => [];
}

class AuthStateSentOTP extends AuthState {
  const AuthStateSentOTP();

  @override
  List<Object?> get props => [];
}

class AuthStateConfirmedOTP extends AuthState {
  const AuthStateConfirmedOTP();

  @override
  List<Object?> get props => [];
}

class AuthStateResetPasswordSuccessful extends AuthState {
  const AuthStateResetPasswordSuccessful();

  @override
  List<Object?> get props => [];
}