import 'package:trapper/app/data/model/profile_model.dart';
import 'package:trapper/app/domain/entity/room_info.dart';

class RoomInfoModel extends RoomInfo {
  RoomInfoModel({
    super.id,
    super.object,
    super.timestamp,
    super.lastMessage,
    super.lastMessageType,
    super.sender
  });

  factory RoomInfoModel.fromJson(Map<String, dynamic> json) {
    return RoomInfoModel(
      id: json['id'] as String?,
      object: ProfileModel(
        id: json['object']['id'] as String?,
        name: json['object']['full_name'] as String?,
        photoUrl: json['object']['photo_url'] as String?,
      ),
      timestamp: json['timestamp'],
      lastMessage: json['last_message'],
      lastMessageType: json['type'],
      sender: json['sender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'object': {
        'id': object?.id,
        'full_name': object?.name,
        'photo_url': object?.photoUrl,
      },
      'timestamp': timestamp,
      'last_message': lastMessage,
      'type': lastMessageType,
      'sender': sender,
    };
  }
}
