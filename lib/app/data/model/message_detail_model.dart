
import '../../domain/entity/message_detail.dart';

class MessageDetailModel extends MessageDetail {
  MessageDetailModel({
    required super.id,
    required super.message,
    required super.type,
    required super.timestamp,
    required super.sender,
  });

  factory MessageDetailModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return MessageDetailModel(
      id: json['_id'],
      message: json['content'],
      type: MessageType.fromValue(json['type']),
      timestamp: json['timestamp'],
      sender: json['sender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'type': type.value,
      'timestamp': timestamp,
      'sender': sender,
    };
  }

  factory MessageDetailModel.fromEntity(MessageDetail messageDetail) {
    return MessageDetailModel(
      id: messageDetail.id,
      message: messageDetail.message,
      type: messageDetail.type,
      timestamp: messageDetail.timestamp,
      sender: messageDetail.sender,
    );
  }

  MessageDetailModel copyWith({
    String? id,
    String? message,
    MessageType? type,
    int? timestamp,
    String? sender,
  }) {
    return MessageDetailModel(
      id: id ?? this.id,
      message: message ?? this.message,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      sender: sender ?? this.sender,
    );
  }
}