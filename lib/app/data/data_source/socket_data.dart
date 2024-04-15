import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:trapper/app/data/model/room_info_model.dart';

abstract class SocketData {
  void connect();
  void disconnect();
  Future<void> sendMessage(String message, {Map<String, dynamic>? data});

  Stream<List<RoomInfoModel>> get roomsInfoStream;
}

class SocketDataImpl implements SocketData {
  final Socket _socket;

  final StreamController<List<RoomInfoModel>> _roomsInfoController = StreamController<List<RoomInfoModel>>.broadcast();

  @override
  Stream<List<RoomInfoModel>> get roomsInfoStream => _roomsInfoController.stream;


  SocketDataImpl({required Socket socket}) : _socket = socket;

  @override
  void connect() async {
    _socket.connect();
    _socket.on('on_received_rooms_info', (data) => null);
    _socket.on('on_received_rooms_messages', (data) => null);
    _socket.on('on_received_message', (data) => null);
    _socket.on('on_received_friend_request', (data) => null);
    _socket.on('on_accept_friend_request', (data) => null);
  }

  @override
  void disconnect() {
    _socket.disconnect();
  }

  @override
  Future<void> sendMessage(String message, {Map<String, dynamic>? data}) async {
    _socket.emit(message, data);
  }
}