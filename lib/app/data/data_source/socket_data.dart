import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:pair/pair.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:trapper/app/data/model/profile_model.dart';

import '../model/message_detail_model.dart';
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
}

class SocketDataImpl implements SocketData {
  final Socket _socket;

  final StreamController<List<RoomInfoModel>> _roomsInfoController = StreamController<List<RoomInfoModel>>.broadcast();
  final StreamController<RoomInfoModel> _findFriendController = StreamController<RoomInfoModel>.broadcast();
  final StreamController<Pair<String, List<MessageDetailModel>>> _roomsMessagesController = StreamController<Pair<String, List<MessageDetailModel>>>.broadcast();
  final StreamController<Pair<String, ProfileModel>> _friendRequestController = StreamController<Pair<String, ProfileModel>>.broadcast();
  final StreamController<bool> _connectStatusController = StreamController<bool>.broadcast();

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

  SocketDataImpl({required Socket socket}) : _socket = socket;

  @override
  void connect() async {
    _socket.connect();

    _socket.onAny((event, data) {
      debugPrint("event: $event, data: $data");
    });

    _socket.on('connect', (_) {
      _connectStatusController.add(true);
    });

    _socket.on('disconnect', (_) {
      _connectStatusController.add(false);
    });

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
      final roomId = data['room_id'];
      _roomsMessagesController.add(Pair(roomId, [message]));
    });

    _socket.on('on_found', (data) {
      _findFriendController.add(RoomInfoModel.fromJson(data));
    });

    _socket.on('on_received_friend_request', (data) {
      print("on_received_friend_request");
      _friendRequestController.add(Pair("on_received_friend_request", ProfileModel.fromJson(data['profile'])));
    });

    _socket.on('on_accept_friend_request', (data) {
      print("on_accept_friend_request");
      _friendRequestController.add(Pair("on_accept_friend_request", ProfileModel.fromJson(data['profile'])));
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