part of 'friends_bloc.dart';

class FriendsState extends Equatable {
  final bool isLoading;
  final String? error;
  final bool showError;
  final List<Profile> friends;

  const FriendsState({
    this.isLoading = false,
    this.error,
    this.showError = false,
    this.friends = const [],
  });

  @override
  // TODO: implement props
  List<Object?> get props => [isLoading, error, showError, friends];

  FriendsState copyWith({
    bool? isLoading,
    String? error,
    bool? showError,
    List<Profile>? friends,
  }) {
    return FriendsState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showError: showError ?? this.showError,
      friends: friends ?? this.friends,
    );
  }
}