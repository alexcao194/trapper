import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/connect_data.dart';
import '../../../domain/entity/hobby.dart';
import '../../../domain/use_case/fetch_hobbies.dart';

part 'connect_event.dart';
part 'connect_state.dart';

class ConnectBloc extends Bloc<ConnectEvent, ConnectState> {
  late final FetchHobbies _fetchHobbies;
  ConnectBloc({
    required FetchHobbies fetchHobbies,
  }) : super(ConnectState.initial()) {
    _fetchHobbies = fetchHobbies;
    on<ConnectFetchHobbies>(_onFetchHobbies);
    on<ConnectUpdateData>(_onUpdateData);
  }

  FutureOr<void> _onUpdateData(ConnectUpdateData event, Emitter<ConnectState> emit) {
    emit(state.copyWith(connectData: event.connectData));
  }

  FutureOr<void> _onFetchHobbies(ConnectFetchHobbies event, Emitter<ConnectState> emit) async {
    var result = await _fetchHobbies();
    result.fold(
      (failure) => null,
      (hobbies) => emit(state.copyWith(hobbies: hobbies)),
    );
  }
}
