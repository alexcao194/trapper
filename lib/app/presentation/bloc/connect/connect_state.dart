part of 'connect_bloc.dart';

class ConnectState extends Equatable {
  final ConnectData connectData;

  const ConnectState({required this.connectData});

  factory ConnectState.initial() {
    return const ConnectState(connectData: ConnectData(minAge: 18, maxAge: 100, gender: 1, hobbies: []));
  }

  ConnectState copyWith({
    ConnectData? connectData,
  }) {
    return ConnectState(connectData: connectData ?? this.connectData);
  }

  @override
  List<Object?> get props => [connectData];
}
