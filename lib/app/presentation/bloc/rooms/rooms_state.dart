part of 'rooms_bloc.dart';

class RoomsState extends Equatable {
  final List<RoomInfo> roomsInfo;
  final String? error;

  const RoomsState({
    required this.roomsInfo,
    this.error,
  });

  const RoomsState.initial() : roomsInfo = const [], error = null;

  @override
  List<Object?> get props => [roomsInfo, error];
}
