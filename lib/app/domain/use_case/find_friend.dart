import '../entity/connect_data.dart';
import '../entity/room_info.dart';
import '../repository/socket_repository.dart';

class FindFriend {
  final SocketRepository _socketRepository;

  FindFriend({required SocketRepository socketRepository})
      : _socketRepository = socketRepository;

  Stream<RoomInfo> call(ConnectData data) {
    return _socketRepository.findFriend(data);
  }
}