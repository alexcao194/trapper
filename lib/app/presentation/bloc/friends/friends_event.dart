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

class FriendsSendMessage extends FriendsEvent {
  final String message;

  const FriendsSendMessage({required this.message});

  @override
  List<Object?> get props => [message];
}

class FriendPick extends FriendsEvent {
  final String friendId;

  const FriendPick({required this.friendId});

  @override
  List<Object?> get props => [friendId];
}

class FriendChangeStatus extends FriendsEvent {
  final String friendId;
  final bool status;

  const FriendChangeStatus({required this.friendId, required this.status});

  @override
  List<Object?> get props => [friendId, status];
}

class FriendsReset extends FriendsEvent {
  const FriendsReset();

  @override
  List<Object?> get props => [];
}