import '../repository/socket_repository.dart';

class AddFriend {
  late SocketRepository _socketRepository;
  AddFriend({required SocketRepository socketRepository}) {
    _socketRepository = socketRepository;
  }

  void call(String friendId) {
    _socketRepository.sendFriendRequest(friendId);
  }
}