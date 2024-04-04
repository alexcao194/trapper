import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trapper/config/dio/dio_tools.dart';

import '../../../domain/entity/account.dart';
import '../../../domain/entity/profile.dart';
import '../../../domain/use_case/connect.dart';
import '../../../domain/use_case/disconnect.dart';
import '../../../domain/use_case/login.dart';
import '../../../domain/use_case/register.dart';
import '../../../domain/use_case/validate_token.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late Login _login;
  late Register _register;
  late ValidateToken _validateToken;
  late Stream<bool> _authSubscription;
  late Connect _connect;
  late Disconnect _disconnect;

  AuthBloc({
    required Login login,
    required Register register,
    required ValidateToken validateToken,
    required Stream<bool> authSubscription,
    required Connect connect,
    required Disconnect disconnect,
  }) : super(const AuthStateUnauthenticated()) {
    _login = login;
    _register = register;
    _validateToken = validateToken;
    _authSubscription = authSubscription;
    _connect = connect;
    _disconnect = disconnect;
    on<AuthEventLogin>(_onLogin);
    on<AuthEventRegister>(_onRegister);
    on<AuthEventValidateToken>(_onValidateToken);
    on<AuthEventLogout>(_onLogout);

    add(const AuthEventValidateToken());

    _authSubscription.listen((isAuthenticated) {
      if (!isAuthenticated) {
        _disconnect();
        add(const AuthEventLogout());
      }
    });
  }

  FutureOr<void> _onLogin(AuthEventLogin event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    final result = await _login(event.account);
    result.fold(
      (failure) => emit(AuthStateFailure(error: failure.message)),
      (_) {
        _connect();
        emit(const AuthStateAuthenticated());
      },
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
      (_) {
        _connect();
        emit(const AuthStateAuthenticated());
      },
    );
  }

  FutureOr<void> _onLogout(AuthEventLogout event, Emitter<AuthState> emit) {
    emit(const AuthStateUnauthenticated());
  }
}
