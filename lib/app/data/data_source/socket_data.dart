import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pair/pair.dart';

import '../../../config/socket/app_socket.dart';
import '../model/message_detail_model.dart';
import '../model/profile_model.dart';
import '../model/room_info_model.dart';

abstract class SocketData {
  void connect();
  void disconnect();
  void sendMessage(String message, {Map<String, dynamic>? data});

  Stream<List<RoomInfoModel>> get roomsInfoStream;
  Stream<RoomInfoModel> get findFriendStream;
  Stream<Pair<String, List<MessageDetailModel>>> get roomsMessagesStream;
  Stream<Pair<String, ProfileModel>> get friendRequestStream;
  Stream<bool> get connectStatusStream;
  Stream<Pair<String, bool>> get friendOnlineStream;
}

class SocketDataImpl implements SocketData {

  final StreamController<List<RoomInfoModel>> _roomsInfoController = StreamController<List<RoomInfoModel>>.broadcast();
  final StreamController<RoomInfoModel> _findFriendController = StreamController<RoomInfoModel>.broadcast();
  final StreamController<Pair<String, List<MessageDetailModel>>> _roomsMessagesController = StreamController<Pair<String, List<MessageDetailModel>>>.broadcast();
  final StreamController<Pair<String, ProfileModel>> _friendRequestController = StreamController<Pair<String, ProfileModel>>.broadcast();
  final StreamController<bool> _connectStatusController = StreamController<bool>.broadcast();
  final StreamController<Pair<String, bool>> _friendOnlineController = StreamController<Pair<String, bool>>.broadcast();

  @override
  Stream<List<RoomInfoModel>> get roomsInfoStream => _roomsInfoController.stream;

  @override
  Stream<RoomInfoModel> get findFriendStream => _findFriendController.stream;

  @override
  Stream<Pair<String, List<MessageDetailModel>>> get roomsMessagesStream => _roomsMessagesController.stream;

  @override
  Stream<Pair<String, ProfileModel>> get friendRequestStream => _friendRequestController.stream;

  @override
  Stream<bool> get connectStatusStream => _connectStatusController.stream;

  @override
  Stream<Pair<String, bool>> get friendOnlineStream => _friendOnlineController.stream;

  SocketDataImpl();

  bool _hasConnected = false;
  
  @override
  void connect() async {
    if (_hasConnected) {
      return;
    }
    _hasConnected = true;
    debugPrint("Preparing to connect");
    AppSocket.socket.connect();

    AppSocket.socket.onAny((event, data) {
      debugPrint("event: $event");
    });

    AppSocket.socket.on('connect', (_) {
      _connectStatusController.add(true);
    });

    AppSocket.socket.on('disconnect', (_) {
      _hasConnected = false;
      _connectStatusController.add(false);
    });

    AppSocket.socket.on('on_received_rooms_info', (data) {
      final roomsInfo = (data as List).map((e) => RoomInfoModel.fromJson(e)).toList();
      _roomsInfoController.add(roomsInfo);
    });

    AppSocket.socket.on('on_received_rooms_messages', (data){
      final List<MessageDetailModel> messages = [];
      for (var message in data['list_messages']) {
        messages.add(MessageDetailModel.fromJson(message));
      }
      _roomsMessagesController.add(Pair(data['_id'], messages));
    });

    AppSocket.socket.on('on_received_message', (data) {
      final message = MessageDetailModel.fromJson(data['message']);
      final roomId = data['room_id'];
      _roomsMessagesController.add(Pair(roomId, [message]));
    });

    AppSocket.socket.on('on_found', (data) {
      _findFriendController.add(RoomInfoModel.fromJson(data));
    });

    AppSocket.socket.on('on_received_friend_request', (data) {
      _friendRequestController.add(Pair("on_received_friend_request", ProfileModel.fromJson(data['profile'])));
    });

    AppSocket.socket.on('on_accept_friend_request', (data) {
      _friendRequestController.add(Pair("on_accept_friend_request", ProfileModel.fromJson(data['profile'])));
    });

    AppSocket.socket.on('on_friend_offline', (data) {
      _friendOnlineController.add(Pair(data['userId'], false));
    });

    AppSocket.socket.on('on_friend_online', (data) {
      _friendOnlineController.add(Pair(data['userId'], true));
    });
  }

  @override
  void disconnect() {
    AppSocket.socket.disconnect();
  }

  @override
  void sendMessage(String message, {Map<String, dynamic>? data}) {
    debugPrint("sendMessage: $message, data: $data");
    AppSocket.socket.emit(message, data);
  }
}