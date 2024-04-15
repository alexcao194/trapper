import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/profile.dart';
import '../../../domain/use_case/fetch_friends.dart';

part 'friends_event.dart';

part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  late FetchFriends _fetchFriends;

  FriendsBloc({
    required FetchFriends fetchFriends,
  }) : super(const FriendsState()) {
    _fetchFriends = fetchFriends;
    on<FriendsFetch>(_onFetch);
    on<FriendsAdd>(_onAdd);
  }

  FutureOr<void> _onFetch(FriendsFetch event, Emitter<FriendsState> emit) async {
    emit(state.copyWith(isLoading: true));
    var result = await _fetchFriends();
    result.fold(
      (exception) => emit(state.copyWith(error: exception.message, isLoading: false, showError: true)),
      (friends) => emit(state.copyWith(friends: friends, isLoading: false, showError: false)),
    );
  }

  FutureOr<void> _onAdd(FriendsAdd event, Emitter<FriendsState> emit) {}
}
