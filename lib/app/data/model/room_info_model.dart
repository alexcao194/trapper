import 'package:trapper/app/data/model/profile_model.dart';
import 'package:trapper/app/domain/entity/room_info.dart';

import 'message_detail_model.dart';

class RoomInfoModel extends RoomInfo {
  RoomInfoModel({
    super.id,
    super.profile,
    super.lastMessage,
    super.isFriend,
  });

  factory RoomInfoModel.fromJson(Map<String, dynamic> json) {
    print(json);
    print(json['is_friend']);
    var profile = json['profile'] != null ? ProfileModel.fromJson(json['profile']) : null;
    var lastMessage = json['last_message'] != null ? MessageDetailModel.fromJson(json['last_message']) : null;
    return RoomInfoModel(
      id: json['_id'],
      profile: profile,
      lastMessage: lastMessage,
      isFriend: json['is_friend'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    var profileModel = profile == null ? null : ProfileModel.fromEntity(profile!);
    var lastMessageModel = lastMessage == null ? null : MessageDetailModel.fromEntity(lastMessage!);
    return {
      'id': id,
      'profile': profileModel?.toJson(),
      'last_message': lastMessageModel?.toJson(),
      'isF_friend': isFriend,
    };
  }
}
