part of 'connect_bloc.dart';

sealed class ConnectEvent extends Equatable {
  const ConnectEvent();
}

class ConnectUpdateData extends ConnectEvent {
  final ConnectData connectData;
  const ConnectUpdateData({required this.connectData});

  @override
  List<Object?> get props => [connectData];
}

class ConnectFetchHobbies extends ConnectEvent {
  const ConnectFetchHobbies();

  @override
  List<Object?> get props => [];
}

class ConnectFindFriend extends ConnectEvent {
  const ConnectFindFriend();

  @override
  List<Object?> get props => [];
}

class ConnectFound extends ConnectEvent {
  final RoomInfo roomInfo;
  const ConnectFound({required this.roomInfo});

  @override
  List<Object?> get props => [roomInfo];
}

class ConnectError extends ConnectEvent {
  final String error;
  const ConnectError({required this.error});

  @override
  List<Object?> get props => [error];
}