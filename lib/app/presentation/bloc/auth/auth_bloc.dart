import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';


import '../../../domain/entity/account.dart';
import '../../../domain/entity/profile.dart';
import '../../../domain/use_case/login.dart';
import '../../../domain/use_case/register.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late Login _login;
  late Register _register;

  AuthBloc({
    required Login login,
    required Register register,
  }) : super(const AuthStateUnauthenticated()) {
    _login = login;
    _register = register;
    on<AuthEventLogin>(_onLogin);
    on<AuthEventRegister>(_onRegister);
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
}
