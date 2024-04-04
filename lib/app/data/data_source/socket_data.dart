import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:trapper/app/data/model/room_info_model.dart';
import 'package:trapper/app/domain/entity/message_detail.dart';

import '../model/profile_model.dart';
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
    _socket.on('on_received_rooms_info', (data) {
      final List<RoomInfoModel> roomsInfo = (data['rooms_info'] as List).map((e) => RoomInfoModel.fromJson(e)).toList();
      _roomsInfoController.add(roomsInfo);
    });
    _socket.on('on_fetch_rooms_info_error', (data) => null);
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