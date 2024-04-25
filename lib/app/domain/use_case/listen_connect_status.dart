import '../repository/socket_repository.dart';

class ListenConnectStatus {
  final SocketRepository _socketRepository;

  ListenConnectStatus({required SocketRepository socketRepository})
      : _socketRepository = socketRepository;

  Stream<bool> call() {
    return _socketRepository.listenConnectStatus();
  }
}