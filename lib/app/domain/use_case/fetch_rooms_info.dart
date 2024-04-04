import 'package:trapper/app/domain/entity/room_info.dart';
import 'package:trapper/app/domain/repository/socket_repository.dart';

class FetchRoomsInfo {
  final SocketRepository _repository;

  FetchRoomsInfo({required SocketRepository repository}) : _repository = repository;

  Stream<List<RoomInfo>> call() {
    return _repository.fetchRoomsInfo();
  }
}