import 'package:trapper/app/domain/entity/message_detail.dart';
import 'package:trapper/app/domain/entity/profile.dart';

class RoomInfo {
  final String? id;
  final String? sender;
  final Profile? object;
  final int? timestamp;
  final String? lastMessage;
  final MessageType? lastMessageType;

  RoomInfo({
    this.id,
    this.object,
    this.timestamp,
    this.lastMessage,
    this.lastMessageType,
    this.sender
  });

  RoomInfo copyWith({
    String? id,
    Profile? object,
    int? timestamp,
    String? lastMessage,
    MessageType? lastMessageType,
    String? sender
  }) {
    return RoomInfo(
      id: id ?? this.id,
      object: object ?? this.object,
      timestamp: timestamp ?? this.timestamp,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageType: lastMessageType ?? this.lastMessageType,
      sender: sender ?? this.sender
    );
  }
}