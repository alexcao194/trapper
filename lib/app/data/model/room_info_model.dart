import 'package:trapper/app/data/model/profile_model.dart';
import 'package:trapper/app/domain/entity/room_info.dart';

import 'message_detail_model.dart';

class RoomInfoModel extends RoomInfo {
  RoomInfoModel({
    super.id,
    super.profile,
    super.lastMessage,
  });

  factory RoomInfoModel.fromJson(Map<String, dynamic> json) {
    var profile = json['profile'] != null ? ProfileModel.fromJson(json['profile']) : null;
    var lastMessage = json['last_message'] != null ? MessageDetailModel.fromJson(json['last_message']) : null;
    print(lastMessage);
    return RoomInfoModel(
      id: json['_id'],
      profile: profile,
      lastMessage: lastMessage,
    );
  }

  Map<String, dynamic> toJson() {
    var profileModel = profile == null ? null : ProfileModel.fromEntity(profile!);
    var lastMessageModel = lastMessage == null ? null : MessageDetailModel.fromEntity(lastMessage!);
    return {
      'id': id,
      'profile': profileModel?.toJson(),
      'lastMessage': lastMessageModel?.toJson(),
    };
  }
}
