import 'package:pair/pair.dart';

import '../entity/message_detail.dart';
import '../repository/socket_repository.dart';

class ListenMessage {
  final SocketRepository _socketRepository;

  ListenMessage({required SocketRepository socketRepository}) : _socketRepository = socketRepository;

  Stream<Pair<String, List<MessageDetail>>> call() {
    return _socketRepository.listenMessage();
  }
}