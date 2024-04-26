import '../../../config/dio/dio_tools.dart';
import '../../domain/entity/message_detail.dart';

class MessageDetailModel extends MessageDetail {
  MessageDetailModel({
    required super.id,
    required super.message,
    required super.type,
    required super.timestamp,
    required super.sender,
    super.image,
  });

  factory MessageDetailModel.fromJson(Map<String, dynamic> json) {
    String message = '';
    switch (json['type']) {
      case 'image':
        message = '${DioTools.baseUrl}/${json['content']}';
      case 'emoji':
        message = json['content'];
      default:
        message = json['content'];
    }
    return MessageDetailModel(
      id: json['_id'],
      message: message,
      type: MessageType.fromValue(json['type'] ?? 'text'),
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
}