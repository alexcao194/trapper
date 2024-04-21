import '../repository/socket_repository.dart';

class CancelFind {
  final SocketRepository _repository;

  CancelFind({required SocketRepository repository}) : _repository = repository;

  Future<void> call() async {
    return _repository.cancelFindFriend();
  }
}