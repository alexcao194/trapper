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
  final String id;
  final String message;
  final MessageType type;
  final int timestamp;
  final String sender;

  MessageDetail({
    required this.id,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.sender,
  });

  @override
  String toString() {
    return 'MessageDetail{id: $id, message: $message, type: ${type.value}, timestamp: $timestamp, sender: $sender}';
  }
}
