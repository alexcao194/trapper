import 'package:pair/pair.dart';
import 'package:trapper/app/domain/entity/profile.dart';

import '../../domain/entity/connect_data.dart';
import '../../domain/entity/message_detail.dart';
import '../../domain/entity/room_info.dart';
import '../../domain/repository/socket_repository.dart';
import '../data_source/remote_data.dart';
import '../data_source/socket_data.dart';

class SocketRepositoryImpl implements SocketRepository {
  late SocketData _socketData;
  late RemoteData _remoteData;
  SocketRepositoryImpl({required SocketData socketData, required RemoteData remoteData}) {
    _socketData = socketData;
    _remoteData = remoteData;
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

  @override
  void sendMessage({required String roomID, required MessageDetail message}) async {
    if (message.type == MessageType.image) {
      var content = await _remoteData.sendImage(image: message.image!, roomId: roomID);
      message = message.copyWith(message: content);
    }
    _socketData.sendMessage('on_send_message', data: {
      'room_id': roomID,
      'content': message.message,
      'type': message.type.value,
    });
  }

  @override
  void cancelFindFriend() {
    _socketData.sendMessage('on_find_cancel');
  }

  @override
  void sendFriendRequest(String userID) {
    _socketData.sendMessage('on_friend_request', data: {'user_id': userID});
  }

  @override
  Stream<Pair<String, Profile>> listenFriend() {
    return _socketData.friendRequestStream;
  }

  @override
  Stream<bool> listenConnectStatus() {
    return _socketData.connectStatusStream;
  }
}