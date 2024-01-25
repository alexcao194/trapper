import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trapper/app/domain/entity/profile.dart';
import 'package:trapper/app/domain/use_case/login.dart';

import '../../../domain/entity/account.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  late Login _login;

  AuthBloc({
    required Login login,
  }) : super(const AuthStateUnauthenticated()) {
    _login = login;
    on<AuthEventLogin>(_onLogin);
  }

  FutureOr<void> _onLogin(AuthEventLogin event, Emitter<AuthState> emit) async {
    emit(const AuthStateLoading());
    final result = await _login(event.account);
    result.fold(
      (failure) => emit(AuthStateFailure(error: failure.message)),
      (_) => emit(const AuthStateAuthenticated()),
    );
  }
}
