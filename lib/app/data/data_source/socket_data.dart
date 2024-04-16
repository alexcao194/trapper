import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pair/pair.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../model/message_detail_model.dart';
import '../model/room_info_model.dart';

abstract class SocketData {
  void connect();
  void disconnect();
  void sendMessage(String message, {Map<String, dynamic>? data});

  Stream<List<RoomInfoModel>> get roomsInfoStream;
  Stream<RoomInfoModel> get findFriendStream;
  Stream<Pair<String, List<MessageDetailModel>>> get roomsMessagesStream;
}

class SocketDataImpl implements SocketData {
  final Socket _socket;

  final StreamController<List<RoomInfoModel>> _roomsInfoController = StreamController<List<RoomInfoModel>>.broadcast();
  final StreamController<RoomInfoModel> _findFriendController = StreamController<RoomInfoModel>.broadcast();
  final StreamController<Pair<String, List<MessageDetailModel>>> _roomsMessagesController = StreamController<Pair<String, List<MessageDetailModel>>>.broadcast();

  @override
  Stream<List<RoomInfoModel>> get roomsInfoStream => _roomsInfoController.stream;

  @override
  Stream<RoomInfoModel> get findFriendStream => _findFriendController.stream;

  @override
  Stream<Pair<String, List<MessageDetailModel>>> get roomsMessagesStream => _roomsMessagesController.stream;

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
    _socket.on('on_received_rooms_messages', (data){
      final List<MessageDetailModel> messages = [];
      for (var message in data['list_messages']) {
        messages.add(MessageDetailModel.fromJson(message));
      }
      _roomsMessagesController.add(Pair(data['_id'], messages));
    });
    _socket.on('on_received_message', (data) {
      final message = MessageDetailModel.fromJson(data['message']);
      final room_id = data['room_id'];
      _roomsMessagesController.add(Pair(room_id, [message]));
    });
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