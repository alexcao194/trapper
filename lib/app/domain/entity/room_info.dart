import 'package:trapper/app/domain/entity/message_detail.dart';
import 'package:trapper/app/domain/entity/profile.dart';

class RoomInfo {
  final String? id;
  final Profile? profile;
  final MessageDetail? lastMessage;
  final bool isFriend;
  final int? timestamp;

  RoomInfo({
    this.id,
    this.profile,
    this.lastMessage,
    this.isFriend = false,
    this.timestamp,
  });

  RoomInfo copyWith({
    String? id,
    Profile? profile,
    MessageDetail? lastMessage,
    bool? isFriend,
    int? timestamp,
  }) {
    return RoomInfo(
      id: id ?? this.id,
      profile: profile ?? this.profile,
      lastMessage: lastMessage ?? this.lastMessage,
      isFriend: isFriend ?? this.isFriend,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() {
    return 'RoomInfo(id: $id, profile: $profile, lastMessage: $lastMessage, isFriend: $isFriend timestamp: $timestamp)';
  }
}