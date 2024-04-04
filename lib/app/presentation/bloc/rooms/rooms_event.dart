part of 'rooms_bloc.dart';

sealed class RoomsEvent extends Equatable {
  const RoomsEvent();
}

final class RoomsFetchRoomsInfo extends RoomsEvent {
  @override
  List<Object> get props => [];
}

final class RoomsUpdateRoomsInfo extends RoomsEvent {
  final List<RoomInfo>? roomsInfo;
  final String? error;

  const RoomsUpdateRoomsInfo({
    this.roomsInfo,
    this.error,
  });

  @override
  List<Object> get props => [roomsInfo ?? [], error ?? ""];
}
