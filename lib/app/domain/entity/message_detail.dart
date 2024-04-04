enum MessageType {
  text,
  image,
  emoji,
}

class MessageDetail {
  final String? id;
  final String? message;
  final MessageType? type;
  final int? timestamp;
  final String? sender;

  MessageDetail({
    this.id,
    this.message,
    this.type,
    this.timestamp,
    this.sender,
  });
}
