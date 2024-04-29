import 'package:pair/pair.dart';

import '../repository/socket_repository.dart';

class ListenOnlineFriends {
  final SocketRepository _socketRepository;

  const ListenOnlineFriends({required SocketRepository socketRepository}) : _socketRepository = socketRepository;

  Stream<Pair<String, bool>> call() {
    return _socketRepository.listenFriendOnline();
  }
}