part of 'rooms_bloc.dart';

class RoomsState extends Equatable {
  final List<RoomInfo> roomsInfo;
  final String? error;
  final Map<String, List<MessageDetail>> messages;

  const RoomsState({
    required this.roomsInfo,
    this.error,
    this.messages = const {},
  });

  const RoomsState.initial() : roomsInfo = const [], error = null, messages = const {};

  @override
  List<Object?> get props => [roomsInfo, error, messages];
}
