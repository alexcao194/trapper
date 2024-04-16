import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trapper/app/data/model/room_info_model.dart';

abstract class SocketData {
  void connect();
  void disconnect();
  void sendMessage(String message, {Map<String, dynamic>? data});

  Stream<List<RoomInfoModel>> get roomsInfoStream;
  Stream<RoomInfoModel> get findFriendStream;
}

class SocketDataImpl implements SocketData {
  final Socket _socket;

  final StreamController<List<RoomInfoModel>> _roomsInfoController = StreamController<List<RoomInfoModel>>.broadcast();
  final StreamController<RoomInfoModel> _findFriendController = StreamController<RoomInfoModel>.broadcast();

  @override
  Stream<List<RoomInfoModel>> get roomsInfoStream => _roomsInfoController.stream;

  @override
  Stream<RoomInfoModel> get findFriendStream => _findFriendController.stream;

  SocketDataImpl({required Socket socket}) : _socket = socket;

  @override
  void connect() async {
    _socket.connect();
    _socket.onAny((event, data) {
      if (kDebugMode) {
        print('event: $event, data: $data');
      }});
    _socket.on('on_received_rooms_info', (data) {
      final roomsInfo = (data as List).map((e) => RoomInfoModel.fromJson(e)).toList();
      _roomsInfoController.add(roomsInfo);
    });
    _socket.on('on_received_rooms_messages', (data) => null);
    _socket.on('on_received_message', (data) => null);
    _socket.on('on_received_friend_request', (data) => null);
    _socket.on('on_accept_friend_request', (data) => null);
    _socket.on('on_found', (data) {
      print("object");
      _findFriendController.add(RoomInfoModel.fromJson(data));
    });
  }

  @override
  void disconnect() {
    _socket.disconnect();
  }

  @override
  void sendMessage(String message, {Map<String, dynamic>? data}) {
    _socket.emit(message, data);
  }
}