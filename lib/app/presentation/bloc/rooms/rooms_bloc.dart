import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/message_detail.dart';
import '../../../domain/entity/room_info.dart';
import '../../../domain/use_case/fect_message.dart';
import '../../../domain/use_case/fetch_rooms_info.dart';
import '../../../domain/use_case/listen_message.dart';

part 'rooms_event.dart';

part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  late FetchRoomsInfo _fetchRoomsInfo;
  late ListenMessage _listenMessage;
  late FetchMessage _fetchMessage;

  StreamSubscription<List<RoomInfo>>? _roomsInfoSubscription;

  RoomsBloc({
    required FetchRoomsInfo fetchRoomsInfo,
    required ListenMessage listenMessage,
    required FetchMessage fetchMessage,
  }) : super(const RoomsState.initial()) {
    _fetchRoomsInfo = fetchRoomsInfo;
    _listenMessage = listenMessage;
    _fetchMessage = fetchMessage;
    on<RoomsFetchRoomsInfo>(_onFetchRoomsInfo);
    on<RoomsUpdateRoomsInfo>(_onUpdateRoomsInfo);
    on<RoomsPick>(_onPick);
  }

  FutureOr<void> _onFetchRoomsInfo(RoomsFetchRoomsInfo event, Emitter<RoomsState> emit) async {
    if (_roomsInfoSubscription != null) {
      return;
    }
    _listenMessage().listen((pair) {
      final newMessages = pair.value;
      final id = pair.key;
      final oldMessages = state.messages[id] ?? [];
      final messages = newMessages.where((newMessage) => !oldMessages.any((oldMessage) => oldMessage.id == newMessage.id)).toList();
      add(RoomsUpdateRoomsInfo(roomsState: state.copyWith(
        messages: {
          ...state.messages,
          id: [
            ...state.messages[id] ?? [],
            ...messages,
          ]
            ..sort(
            (a, b) => - a.timestamp.compareTo(b.timestamp),
          ),
        },
      )));
    });
    _roomsInfoSubscription = _fetchRoomsInfo().listen(
      (roomsInfo) {
        if (roomsInfo.isEmpty) {
          add(RoomsUpdateRoomsInfo(roomsState: state.copyWith(error: 'No rooms found.')));
          return;
        }
        if (state.currentID == null) {
          _fetchMessage(roomsInfo.first.id!);
        }
        add(RoomsUpdateRoomsInfo(roomsState: state.copyWith(roomsInfo: roomsInfo, currentID: roomsInfo.first.id)));
      },
      onError: (error) {
        add(RoomsUpdateRoomsInfo(roomsState: state.copyWith(error: error.toString())));
      },
    );
  }

  FutureOr<void> _onUpdateRoomsInfo(RoomsUpdateRoomsInfo event, Emitter<RoomsState> emit) {
    print(event.roomsState.messages);
    emit(event.roomsState);
  }

  FutureOr<void> _onPick(RoomsPick event, Emitter<RoomsState> emit) {
    _fetchMessage(event.id);
    emit(state.copyWith(currentID: event.id));
  }
}
