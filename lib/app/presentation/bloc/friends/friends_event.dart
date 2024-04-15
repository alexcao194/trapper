part of 'friends_bloc.dart';

sealed class FriendsEvent extends Equatable {
  const FriendsEvent();
}

class FriendsFetch extends FriendsEvent {
  const FriendsFetch();

  @override
  List<Object?> get props => [];
}

class FriendsAdd extends FriendsEvent {
  final String friendId;

  const FriendsAdd({required this.friendId});

  @override
  List<Object?> get props => [friendId];
}