import 'package:trapper/app/domain/repository/socket_repository.dart';

class Connect {
  late SocketRepository _socketRepository;
  Connect({required SocketRepository socketRepository}) {
    _socketRepository = socketRepository;
  }

  void call() {
    _socketRepository.connect();
  }
}