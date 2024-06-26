import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/entity/profile.dart';
import '../../../domain/use_case/add_friend.dart';
import '../../../domain/use_case/fetch_friends.dart';
import '../../../domain/use_case/listen_friend.dart';
import '../../../domain/use_case/listen_online_friends.dart';

part 'friends_event.dart';

part 'friends_state.dart';

class FriendsBloc extends Bloc<FriendsEvent, FriendsState> {
  late FetchFriends _fetchFriends;
  late AddFriend _addFriend;
  late ListenFriend _listenFriend;
  late ListenOnlineFriends _listenOnlineFriends;

  StreamSubscription? _listenFriendSubscription;

  FriendsBloc({
    required FetchFriends fetchFriends,
    required AddFriend addFriend,
    required ListenFriend listenFriend,
    required ListenOnlineFriends listenOnlineFriends,
  }) : super(const FriendsState()) {
    _fetchFriends = fetchFriends;
    _addFriend = addFriend;
    _listenFriend = listenFriend;
    _listenOnlineFriends = listenOnlineFriends;
    on<FriendsFetch>(_onFetch);
    on<FriendsAdd>(_onAdd);
    on<FriendsSendMessage>(_onSendMessage);
    on<FriendPick>(_onPick);
    on<FriendChangeStatus>(_onFriendChangeStatus);
    on<FriendsReset>(_onReset);


    if (_listenFriendSubscription != null) {
      _listenFriendSubscription!.cancel();
    }

    _listenFriendSubscription = _listenFriend().listen((event) {
      if (event.key == 'on_accept_friend_request') {
        add(const FriendsFetch());
        add(FriendsSendMessage(message: S.current.accept_request(event.value.name!)));
      }

      // if (event.key == 'on_received_friend_request') {
      //   add(FriendsSendMessage(message: S.current.received_request(event.value.name!)));
      // }
    });

    _listenOnlineFriends().listen((event) {
      add(FriendChangeStatus(friendId: event.key, status: event.value));
    });
  }

  FutureOr<void> _onFetch(FriendsFetch event, Emitter<FriendsState> emit) async {
    emit(state.copyWith(isLoading: true, showError: false, error: null, message: null, showMessages: false));
    var result = await _fetchFriends();
    result.fold(
      (exception) => emit(state.copyWith(error: exception.message, isLoading: false, showError: true, showMessages: false)),
      (friends) {
        if (friends.isEmpty) {
          emit(state.copyWith(isLoading: false, showError: false, error: null, showMessages: false));
        } else {
          emit(state.copyWith(friends: friends, isLoading: false, showError: false, showMessages: false, currentID: state.currentID ?? friends.first.id));
        }
      },
    );
  }

  FutureOr<void> _onAdd(FriendsAdd event, Emitter<FriendsState> emit) {
    _addFriend(event.friendId);
    emit(state.copyWith(isLoading: false, showError: false, error: null, message: null, showMessages: false));
    add(FriendsSendMessage(message: S.current.sent_request));
  }

  FutureOr<void> _onSendMessage(FriendsSendMessage event, Emitter<FriendsState> emit) {
    emit(state.copyWith(isLoading: false, showError: false, error: null, message: event.message, showMessages: true));
    emit(state.copyWith(isLoading: false, showError: false, error: null, message: null, showMessages: false));
  }

  FutureOr<void> _onPick(FriendPick event, Emitter<FriendsState> emit) {
    emit(state.copyWith(currentID: event.friendId));
  }

  FutureOr<void> _onFriendChangeStatus(FriendChangeStatus event, Emitter<FriendsState> emit) {
    var friends = state.friends.map((e) {
      if (e.id == event.friendId) {
        return e.copyWith(online: event.status);
      }
      return e;
    }).toList();
    emit(state.copyWith(friends: friends));
  }

  FutureOr<void> _onReset(FriendsReset event, Emitter<FriendsState> emit) {
    emit(const FriendsState());
  }
}
