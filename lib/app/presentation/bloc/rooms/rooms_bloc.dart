import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/room_info.dart';
import '../../../domain/use_case/fetch_rooms_info.dart';

part 'rooms_event.dart';

part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  late FetchRoomsInfo _fetchRoomsInfo;

  RoomsBloc({
    required FetchRoomsInfo fetchRoomsInfo,
  }) : super(const RoomsState.initial()) {
    _fetchRoomsInfo = fetchRoomsInfo;
    on<RoomsFetchRoomsInfo>(_onFetchRoomsInfo);
    on<RoomsUpdateRoomsInfo>(_onUpdateRoomsInfo);
  }

  FutureOr<void> _onFetchRoomsInfo(RoomsFetchRoomsInfo event, Emitter<RoomsState> emit) async {
    _fetchRoomsInfo().listen(
      (roomsInfo) {
        add(RoomsUpdateRoomsInfo(roomsInfo: roomsInfo));
      },
      onError: (error) {
        add(RoomsUpdateRoomsInfo(error: error.toString()));
      },
    );
  }

  FutureOr<void> _onUpdateRoomsInfo(RoomsUpdateRoomsInfo event, Emitter<RoomsState> emit) {
    emit(RoomsState(
      roomsInfo: event.roomsInfo ?? state.roomsInfo,
      error: event.error,
    ));
  }
}
