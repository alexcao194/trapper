part of 'friends_bloc.dart';

class FriendsState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool showError;
  final List<Profile> friends;
  final String? message;
  final bool showMessages;

  const FriendsState({
    this.isLoading = false,
    this.error,
    this.showError = false,
    this.friends = const [],
    this.message,
    this.showMessages = false,
  });

  @override
  List<Object?> get props => [isLoading, error, showError, friends, message, showMessages];

  FriendsState copyWith({
    bool? isLoading,
    String? error,
    bool? showError,
    List<Profile>? friends,
    String? message,
    bool? showMessages,
  }) {
    return FriendsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showError: showError ?? this.showError,
      friends: friends ?? this.friends,
      message: message ?? this.message,
      showMessages: showMessages ?? this.showMessages,
    );
  }
}