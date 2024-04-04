import 'package:trapper/app/domain/repository/socket_repository.dart';

class Disconnect {
  late SocketRepository _socketRepository;
  Disconnect({required SocketRepository socketRepository}) {
    _socketRepository = socketRepository;
  }
  
  void call() {
    _socketRepository.disconnect();
  }
}