part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final Profile profile;
  final String? message;
  final bool isLoading;
  final bool sendMessage;
  const ProfileState({required this.profile, this.message, this.isLoading = false, this.sendMessage = false});

  @override
  List<Object?> get props => [profile, message, isLoading, sendMessage];

  ProfileState copyWith({
    Profile? profile,
    String? message,
    bool? isLoading,
    bool? sendMessage,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      sendMessage: sendMessage ?? this.sendMessage,
    );
  }
}