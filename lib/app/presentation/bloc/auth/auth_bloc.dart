import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../domain/entity/account.dart';
import '../../../domain/entity/profile.dart';
import '../../../domain/use_case/login.dart';
import '../../../domain/use_case/register.dart';
import '../../../domain/use_case/validate_token.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late Login _login;
  late Register _register;
  late ValidateToken _validateToken;

  AuthBloc({
    required Login login,
    required Register register,
    required ValidateToken validateToken,
  }) : super(const AuthStateUnauthenticated()) {
    _login = login;
    _register = register;
    _validateToken = validateToken;
    on<AuthEventLogin>(_onLogin);
    on<AuthEventRegister>(_onRegister);
    on<AuthEventValidateToken>(_onValidateToken);
    on<AuthEventLogout>(_onLogout);
  }

  FutureOr<void> _onLogin(AuthEventLogin event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    final result = await _login(event.account);
    result.fold(
      (failure) => emit(AuthStateFailure(error: failure.message)),
      (_) => emit(const AuthStateAuthenticated()),
    );
  }

  FutureOr<void> _onRegister(AuthEventRegister event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    final result = await _register(event.account, event.profile);
    result.fold(
      (failure) => emit(AuthStateFailure(error: failure.message)),
      (_) => emit(const AuthStateAuthenticated()),
    );
  }

  FutureOr<void> _onValidateToken(AuthEventValidateToken event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    final result = await _validateToken();
    result.fold(
      (failure) => emit(AuthStateFailure(error: failure.message)),
      (_) => emit(const AuthStateAuthenticated()),
    );
  }

  FutureOr<void> _onLogout(AuthEventLogout event, Emitter<AuthState> emit) {
  }
}
