part of 'connect_bloc.dart';

class ConnectState extends Equatable {
  final ConnectData connectData;
  final List<Hobby> hobbies;
  final bool isLoading;
  final String? error;
  final bool showError;
  final RoomInfo? roomInfo;

  const ConnectState({required this.connectData, required this.hobbies, this.isLoading = false, this.error, this.showError = false, this.roomInfo});

  factory ConnectState.initial() {
    return const ConnectState(connectData: ConnectData(minAge: 21, maxAge: 23, gender: true, hobbies: []), hobbies: []);
  }

  ConnectState copyWith({
    ConnectData? connectData,
    List<Hobby>? hobbies,
    bool isLoading = false,
    String? error,
    bool showError = false,
    RoomInfo? roomInfo,
  }) {
    return ConnectState(connectData: connectData ?? this.connectData, hobbies: hobbies ?? this.hobbies, isLoading: isLoading, error: error, showError: showError, roomInfo: roomInfo ?? this.roomInfo);
  }

  @override
  List<Object?> get props => [connectData, hobbies, isLoading, error, showError, roomInfo];
}
