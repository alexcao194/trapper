part of 'rooms_bloc.dart';

class RoomsState extends Equatable {
  final List<RoomInfo> roomsInfo;
  final String? error;
  final String? currentID;
  final Map<String, List<MessageDetail>> messages;

  const RoomsState({
    required this.roomsInfo,
    this.error,
    this.messages = const {},
    this.currentID,
  });

  const RoomsState.initial() : roomsInfo = const [], error = null, messages = const {}, currentID = null;

  @override
  List<Object?> get props => [roomsInfo, error, messages, currentID];

  RoomsState copyWith({
    List<RoomInfo>? roomsInfo,
    String? error,
    Map<String, List<MessageDetail>>? messages,
    String? currentID,
  }) {
    return RoomsState(
      roomsInfo: roomsInfo ?? this.roomsInfo,
      error: error ?? this.error,
      messages: messages ?? this.messages,
      currentID: currentID ?? this.currentID,
    );
  }
}
