import 'package:trapper/app/domain/entity/message_detail.dart';
import 'package:trapper/app/domain/entity/profile.dart';

class RoomInfo {
  final String? id;
  final Profile? profile;
  final MessageDetail? lastMessage;

  RoomInfo({
    this.id,
    this.profile,
    this.lastMessage,
  });

  RoomInfo copyWith({
    String? id,
    Profile? profile,
    MessageDetail? lastMessage,
  }) {
    return RoomInfo(
      id: id ?? this.id,
      profile: profile ?? this.profile,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }
}