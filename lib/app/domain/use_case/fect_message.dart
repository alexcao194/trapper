import '../repository/socket_repository.dart';

class FetchMessage {
  final SocketRepository _socketRepository;

  FetchMessage({required SocketRepository socketRepository}) : _socketRepository = socketRepository;

  void call(String roomId) {
    _socketRepository.fetchMessages(roomId);
  }
}