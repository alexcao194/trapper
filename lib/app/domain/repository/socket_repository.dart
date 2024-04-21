import 'package:pair/pair.dart';

import '../entity/connect_data.dart';
import '../entity/message_detail.dart';
import '../entity/profile.dart';
import '../entity/room_info.dart';

abstract class SocketRepository {
  void connect();
  void disconnect();
  void fetchMessages(String roomId);
  void sendMessage({required String roomID, required MessageDetail message});
  void cancelFindFriend();
  void sendFriendRequest(String userID);
  Stream<List<RoomInfo>> fetchRoomsInfo();
  Stream<RoomInfo> findFriend(ConnectData data);
  Stream<Pair<String, List<MessageDetail>>> listenMessage();
  Stream<Pair<String, Profile>> listenFriend();
}