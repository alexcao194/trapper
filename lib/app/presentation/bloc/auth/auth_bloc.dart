import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/entity/account.dart';
import '../../../domain/entity/profile.dart';
import '../../../domain/use_case/change_password.dart';
import '../../../domain/use_case/connect.dart';
import '../../../domain/use_case/disconnect.dart';
import '../../../domain/use_case/log_out.dart';
import '../../../domain/use_case/login.dart';
import '../../../domain/use_case/register.dart';
import '../../../domain/use_case/send_otp.dart';
import '../../../domain/use_case/validate_token.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late Login _login;
  late Register _register;
  late Logout _logout;
  late ValidateToken _validateToken;
  late Stream<bool> _authSubscription;
  late Connect _connect;
  late Disconnect _disconnect;
  late SendOTP _sendOTP;
  late ChangePassword _changePassword;

  AuthBloc({
    required Login login,
    required Register register,
    required ValidateToken validateToken,
    required Stream<bool> authSubscription,
    required Connect connect,
    required Disconnect disconnect,
    required SendOTP sendOTP,
    required ChangePassword changePassword,
    required Logout logout,
  }) : super(const AuthStateUnauthenticated()) {
    _login = login;
    _register = register;
    _validateToken = validateToken;
    _authSubscription = authSubscription;
    _connect = connect;
    _disconnect = disconnect;
    _sendOTP = sendOTP;
    _changePassword = changePassword;
    _logout = logout;
    on<AuthEventLogin>(_onLogin);
    on<AuthEventRegister>(_onRegister);
    on<AuthEventValidateToken>(_onValidateToken);
    on<AuthEventLogout>(_onLogout);
    on<AuthEventSendOTP>(_onSendOTP);
    on<AuthEventChangePassword>(_onChangePassword);
    on<AuthEventReset>(_onReset);
    

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
      (_) {
        _connect();
        emit(const AuthStateAuthenticated());
      },
    );
  }

  FutureOr<void> _onValidateToken(AuthEventValidateToken event, Emitter<AuthState> emit) async {
    if (state is AuthStateAuthenticated || state is AuthStateLoading) {
      return;
    }
    debugPrint('Preparing to validate token');
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

  FutureOr<void> _onLogout(AuthEventLogout event, Emitter<AuthState> emit) async {
    debugPrint('logout');
    emit(const AuthStateLoading());
    var result = await _logout();
    result.fold(
      (failure) => emit(AuthStateFailure(error: failure.message)),
      (_) {
        debugPrint("logout successful");
        _disconnect();
        emit(const AuthStateUnauthenticated());
      },
    );
  }

  FutureOr<void> _onChangePassword(AuthEventChangePassword event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    var result = await _changePassword(email: event.email, otp: event.otp, password: event.password);
    result.fold(
      (failure) => emit(AuthStateFailure(error: failure.message)),
      (_) => emit(const AuthStateResetPasswordSuccessful()),
    );
  }

  FutureOr<void> _onSendOTP(AuthEventSendOTP event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    var result = await _sendOTP(event.email);
    result.fold(
      (failure) => emit(AuthStateFailure(error: failure.message)),
      (_) => emit(const AuthStateSentOTP()),
    );
  }

  FutureOr<void> _onReset(AuthEventReset event, Emitter<AuthState> emit) {
    emit(const AuthStateUnauthenticated());
  }
}
