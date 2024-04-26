import 'dart:typed_data';

enum MessageType {
  text,
  image,
  emoji;

  static MessageType fromValue(String value) {
    switch(value) {
      case 'image': return MessageType.image;
      case 'emoji': return MessageType.emoji;
      default: return MessageType.text;
    }
  }

  String get value {
    switch(this) {
      case MessageType.emoji: return 'emoji';
      case MessageType.image: return 'image';
      default: return 'text';
    }
  }
}

class MessageDetail {
  final String? id;
  final String? message;
  final MessageType type;
  final int? timestamp;
  final String? sender;
  final Uint8List? image;

  MessageDetail({
    this.id,
    this.message,
    required this.type,
    this.timestamp,
    this.sender,
    this.image
  });

  @override
  String toString() {
    return 'MessageDetail{id: $id, message: $message, type: ${type.value}, timestamp: $timestamp, sender: $sender}';
  }

  MessageDetail copyWith({
    String? id,
    String? message,
    MessageType? type,
    int? timestamp,
    String? sender,
    Uint8List? image,
  }) {
    return MessageDetail(
      id: id ?? this.id,
      message: message ?? this.message,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      sender: sender ?? this.sender,
      image: image ?? this.image,
    );
  }
}
