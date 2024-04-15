import 'package:trapper/app/domain/entity/message_detail.dart';

class MessageDetailModel extends MessageDetail {
  MessageDetailModel({
    super.id,
    super.message,
    super.type,
    super.timestamp,
    super.sender,
  });

  factory MessageDetailModel.fromJson(Map<String, dynamic> json) {
    return MessageDetailModel(
      id: json['id'],
      message: json['message'],
      type: json['type'],
      timestamp: json['timestamp'],
      sender: json['sender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'type': type,
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