import 'package:trapper/app/domain/entity/connect_data.dart';

import '../entity/room_info.dart';

abstract class SocketRepository {
  void connect();
  void disconnect();
  Stream<List<RoomInfo>> fetchRoomsInfo();
  Stream<RoomInfo> findFriend(ConnectData data);
}