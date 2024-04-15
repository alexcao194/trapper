import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trapper/app/domain/use_case/find_friend.dart';
import 'package:trapper/generated/l10n.dart';

import '../../../domain/entity/connect_data.dart';
import '../../../domain/entity/hobby.dart';
import '../../../domain/use_case/fetch_hobbies.dart';

part 'connect_event.dart';
part 'connect_state.dart';

class ConnectBloc extends Bloc<ConnectEvent, ConnectState> {
  late final FetchHobbies _fetchHobbies;
  late final FindFriend _findFriend;
  ConnectBloc({
    required FetchHobbies fetchHobbies,
    required FindFriend findFriend,
  }) : super(ConnectState.initial()) {
    _fetchHobbies = fetchHobbies;
    _findFriend = findFriend;
    on<ConnectFetchHobbies>(_onFetchHobbies);
    on<ConnectUpdateData>(_onUpdateData);
    on<ConnectFindFriend>(_onFindFriend);
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
    _findFriend(state.connectData);
    emit(state.copyWith(isLoading: true, showError: false, error: null));
  }
}
