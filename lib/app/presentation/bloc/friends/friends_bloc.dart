import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/profile.dart';
import '../../../domain/use_case/add_friend.dart';
import '../../../domain/use_case/fetch_friends.dart';
import '../../../domain/use_case/listen_friend.dart';

part 'friends_event.dart';

part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  late FetchFriends _fetchFriends;
  late AddFriend _addFriend;
  late ListenFriend _listenFriend;

  FriendsBloc({
    required FetchFriends fetchFriends,
    required AddFriend addFriend,
    required ListenFriend listenFriend,
  }) : super(const FriendsState()) {
    _fetchFriends = fetchFriends;
    _addFriend = addFriend;
    _listenFriend = listenFriend;
    on<FriendsFetch>(_onFetch);
    on<FriendsAdd>(_onAdd);

    _listenFriend().listen((event) {

    });
  }

  FutureOr<void> _onFetch(FriendsFetch event, Emitter<FriendsState> emit) async {
    emit(state.copyWith(isLoading: true));
    var result = await _fetchFriends();
    result.fold(
      (exception) => emit(state.copyWith(error: exception.message, isLoading: false, showError: true)),
      (friends) => emit(state.copyWith(friends: friends, isLoading: false, showError: false)),
    );
  }

  FutureOr<void> _onAdd(FriendsAdd event, Emitter<FriendsState> emit) {
    _addFriend(event.friendId);
  }
}
