import 'package:pair/pair.dart';

import '../entity/profile.dart';
import '../repository/socket_repository.dart';

class ListenFriend {
  late SocketRepository _socketRepository;
  ListenFriend({required SocketRepository socketRepository}) {
    _socketRepository = socketRepository;
  }

  Stream<Pair<String, Profile>> call() {
    return _socketRepository.listenFriend();
  }
}