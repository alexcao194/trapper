import '../entity/room_info.dart';

abstract class SocketRepository {
  void connect();
  void disconnect();
  Stream<List<RoomInfo>> fetchRoomsInfo();
}