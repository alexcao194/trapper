part of 'rooms_bloc.dart';

sealed class RoomsEvent extends Equatable {
  const RoomsEvent();
}

final class RoomsFetchRoomsInfo extends RoomsEvent {
  const RoomsFetchRoomsInfo();
  @override
  List<Object> get props => [];
}

final class RoomsUpdateRoomsInfo extends RoomsEvent {
  final RoomsState roomsState;

  const RoomsUpdateRoomsInfo({
    required this.roomsState,
  });

  @override
  List<Object> get props => [roomsState];
}

final class RoomsPick extends RoomsEvent {
  final String id;

  const RoomsPick({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

final class RoomPickWithUserId extends RoomsEvent {
  final String userID;

  const RoomPickWithUserId({
    required this.userID,
  });

  @override
  List<Object> get props => [userID];
}

final class RoomsSendMessage extends RoomsEvent {
  final String roomID;
  final MessageDetail message;

  const RoomsSendMessage({
    required this.roomID,
    required this.message,
  });

  @override
  List<Object> get props => [roomID, message];
}

final class RoomsReset extends RoomsEvent {
  const RoomsReset();

  @override
  List<Object> get props => [];
}