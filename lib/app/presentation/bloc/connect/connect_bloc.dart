import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/entity/connect_data.dart';
import '../../../domain/entity/hobby.dart';
import '../../../domain/entity/room_info.dart';
import '../../../domain/use_case/cancel_find.dart';
import '../../../domain/use_case/fetch_hobbies.dart';
import '../../../domain/use_case/find_friend.dart';

part 'connect_event.dart';

part 'connect_state.dart';

class ConnectBloc extends Bloc<ConnectEvent, ConnectState> {
  late final FetchHobbies _fetchHobbies;
  late final FindFriend _findFriend;
  late final CancelFind _cancelFind;

  ConnectBloc({
    required FetchHobbies fetchHobbies,
    required FindFriend findFriend,
    required CancelFind cancelFind,
  }) : super(ConnectState.initial()) {
    _fetchHobbies = fetchHobbies;
    _findFriend = findFriend;
    _cancelFind = cancelFind;
    on<ConnectFetchHobbies>(_onFetchHobbies);
    on<ConnectUpdateData>(_onUpdateData);
    on<ConnectFindFriend>(_onFindFriend);
    on<ConnectFound>(_onConnectFound);
    on<ConnectError>(_onConnectError);
    on<ConnectReset>(_onReset);
    on<ConnectCancelFindFriend>(_onCancelFind);
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

  FutureOr<void> _onFindFriend(ConnectFindFriend event, Emitter<ConnectState> emit) async {
    if (state.connectData.hobbies.isEmpty) {
      emit(state.copyWith(showError: true, error: S.current.no_hobbies_error, isLoading: false));
      return;
    }
    emit(state.copyWith(isLoading: true, showError: false, error: null, roomInfo: null));
    _findFriend(state.connectData).listen((event) {
      add(ConnectFound(roomInfo: event));
    }, onError: (error) {
      add(ConnectError(error: error.toString()));
    });
  }

  FutureOr<void> _onConnectFound(ConnectFound event, Emitter<ConnectState> emit) {
    emit(state.copyWith(isLoading: false, roomInfo: event.roomInfo, showError: false, error: null));
  }

  FutureOr<void> _onConnectError(ConnectError event, Emitter<ConnectState> emit) {
    emit(state.copyWith(isLoading: false, showError: true, error: event.error));
  }

  FutureOr<void> _onReset(ConnectReset event, Emitter<ConnectState> emit) {
    emit(ConnectState.initial());
  }

  FutureOr<void> _onCancelFind(ConnectCancelFindFriend event, Emitter<ConnectState> emit) {
    _cancelFind();
  }
}
