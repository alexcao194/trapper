import 'package:pair/pair.dart';
import 'package:trapper/app/domain/entity/connect_data.dart';
import 'package:trapper/app/domain/entity/message_detail.dart';

import '../entity/room_info.dart';

abstract class SocketRepository {
  void connect();
  void disconnect();
  Stream<List<RoomInfo>> fetchRoomsInfo();
  Stream<RoomInfo> findFriend(ConnectData data);
  Stream<Pair<String, List<MessageDetail>>> listenMessage();
  void fetchMessages(String roomId);
  void sendMessage({required String roomID, required MessageDetail message});
}