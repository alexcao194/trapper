part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final Profile profile;
  final String? message;
  final String? error;
  final bool isLoading;
  final bool sendMessage;
  final bool sendError;

  const ProfileState({
    required this.profile,
    this.message,
    this.isLoading = false,
    this.sendMessage = false,
    this.sendError = false,
    this.error,
  });

  @override
  List<Object?> get props => [profile, message, isLoading, sendMessage, sendError, error];

  ProfileState copyWith({
    Profile? profile,
    String? message,
    bool? isLoading,
    bool? sendMessage,
    String? error,
    bool? sendError,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      message: message ?? this.message,
      isLoading: isLoading ?? this.isLoading,
      sendMessage: sendMessage ?? this.sendMessage,
      sendError: sendError ?? this.sendError,
      error: error ?? this.error,
    );
  }
}
