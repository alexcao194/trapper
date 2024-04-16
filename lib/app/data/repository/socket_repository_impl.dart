import 'package:pair/pair.dart';

import '../../domain/entity/connect_data.dart';
import '../../domain/entity/message_detail.dart';
import '../../domain/entity/room_info.dart';
import '../../domain/repository/socket_repository.dart';
import '../data_source/socket_data.dart';

class SocketRepositoryImpl implements SocketRepository {
  late SocketData _socketData;
  SocketRepositoryImpl({required SocketData socketData}) {
    _socketData = socketData;
  }

  @override
  void connect() {
    _socketData.connect();
  }

  @override
  void disconnect() {
    _socketData.disconnect();
  }

  @override
  Stream<List<RoomInfo>> fetchRoomsInfo() {
    _socketData.sendMessage('on_fetch_rooms_info');
    return _socketData.roomsInfoStream.map((roomsInfo) => roomsInfo);
  }

  @override
  Stream<RoomInfo> findFriend(ConnectData data) {
    _socketData.sendMessage('on_find', data: {
      'min_age': data.minAge,
      'max_age': data.maxAge,
      'gender': data.gender,
      'hobbies': data.hobbies
    });
    return _socketData.findFriendStream.map((roomsInfo) => roomsInfo);
  }

  @override
  Stream<Pair<String, List<MessageDetail>>> listenMessage() {
    return _socketData.roomsMessagesStream;
  }

  @override
  void fetchMessages(String roomId) {
    _socketData.sendMessage('on_fetch_rooms_messages', data: {'room_id': roomId});
  }
}