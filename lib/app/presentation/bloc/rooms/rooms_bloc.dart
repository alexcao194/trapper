import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/message_detail.dart';
import '../../../domain/entity/room_info.dart';
import '../../../domain/use_case/fect_message.dart';
import '../../../domain/use_case/fetch_rooms_info.dart';
import '../../../domain/use_case/listen_connect_status.dart';
import '../../../domain/use_case/listen_message.dart';
import '../../../domain/use_case/send_message.dart';

part 'rooms_event.dart';

part 'rooms_state.dart';

class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  late FetchRoomsInfo _fetchRoomsInfo;
  late ListenMessage _listenMessage;
  late FetchMessage _fetchMessage;
  late SendMessage _sendMessage;
  late ListenConnectStatus _listenConnectStatus;

  StreamSubscription<List<RoomInfo>>? _roomsInfoSubscription;

  List<RoomInfo> roomsInfo = [];

  RoomsBloc({
    required FetchRoomsInfo fetchRoomsInfo,
    required ListenMessage listenMessage,
    required FetchMessage fetchMessage,
    required SendMessage sendMessage,
    required ListenConnectStatus listenConnectStatus,
  }) : super(const RoomsState.initial()) {
    _fetchRoomsInfo = fetchRoomsInfo;
    _listenMessage = listenMessage;
    _fetchMessage = fetchMessage;
    _sendMessage = sendMessage;
    _listenConnectStatus = listenConnectStatus;
    on<RoomsFetchRoomsInfo>(_onFetchRoomsInfo);
    on<RoomsUpdateRoomsInfo>(_onUpdateRoomsInfo);
    on<RoomsPick>(_onPick);
    on<RoomsSendMessage>(_onSendMessage);
    on<RoomPickWithUserId>(_onPickWithUserId);
    on<RoomsReset>(_onReset);

    _listenConnectStatus().listen((isConnected) {
      if (isConnected) {
        add(const RoomsFetchRoomsInfo());
      }
    });
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
      add(RoomsUpdateRoomsInfo(
          roomsState: state.copyWith(
        messages: {
          ...state.messages,
          id: [
            ...state.messages[id] ?? [],
            ...messages,
          ]..sort(
              (a, b) => -a.timestamp!.compareTo(b.timestamp!),
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
        var tmpInfo = roomsInfo..sort((a, b) {
          final aTime = a.lastMessage?.timestamp ?? a.timestamp!;
          final bTime = b.lastMessage?.timestamp ?? b.timestamp!;
          return -aTime.compareTo(bTime);

        });
        if (state.currentID == null) {
          _fetchMessage(tmpInfo.first.id!);
        }
        add(
          RoomsUpdateRoomsInfo(
            roomsState: state.copyWith(
              roomsInfo: tmpInfo,
              currentID: state.currentID ?? roomsInfo.first.id,
            ),
          ),
        );
      },
      onError: (error) {
        add(RoomsUpdateRoomsInfo(roomsState: state.copyWith(error: error.toString())));
      },
    );
  }

  FutureOr<void> _onUpdateRoomsInfo(RoomsUpdateRoomsInfo event, Emitter<RoomsState> emit) {
    emit(event.roomsState);
  }

  FutureOr<void> _onPick(RoomsPick event, Emitter<RoomsState> emit) {
    _fetchMessage(event.id);
    emit(state.copyWith(currentID: event.id));
  }

  FutureOr<void> _onSendMessage(RoomsSendMessage event, Emitter<RoomsState> emit) {
    _sendMessage(
      message: event.message,
      roomID: event.roomID,
    );
  }

  FutureOr<void> _onPickWithUserId(RoomPickWithUserId event, Emitter<RoomsState> emit) {
    final room = state.roomsInfo.firstWhere((element) => element.profile!.id == event.userID);
    _fetchMessage(room.id!);
    emit(state.copyWith(currentID: room.id));
  }

  FutureOr<void> _onReset(RoomsReset event, Emitter<RoomsState> emit) {
    emit(const RoomsState.initial());
  }
}
