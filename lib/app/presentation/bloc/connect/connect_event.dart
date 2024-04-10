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