import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/connect_data.dart';

part 'connect_event.dart';
part 'connect_state.dart';

class ConnectBloc extends Bloc<ConnectEvent, ConnectState> {
  ConnectBloc() : super(ConnectState.initial()) {
    on<ConnectUpdateData>(_onUpdateData);
  }

  FutureOr<void> _onUpdateData(ConnectUpdateData event, Emitter<ConnectState> emit) {
    emit(state.copyWith(connectData: event.connectData));
  }
}
