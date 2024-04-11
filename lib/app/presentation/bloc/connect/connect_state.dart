part of 'connect_bloc.dart';

class ConnectState extends Equatable {
  final ConnectData connectData;
  final List<Hobby> hobbies;

  const ConnectState({required this.connectData, required this.hobbies});

  factory ConnectState.initial() {
    return const ConnectState(connectData: ConnectData(minAge: 21, maxAge: 23, gender: 1, hobbies: []), hobbies: []);
  }

  ConnectState copyWith({
    ConnectData? connectData,
    List<Hobby>? hobbies,
  }) {
    return ConnectState(connectData: connectData ?? this.connectData, hobbies: hobbies ?? this.hobbies);
  }

  @override
  List<Object?> get props => [connectData, hobbies];
}
