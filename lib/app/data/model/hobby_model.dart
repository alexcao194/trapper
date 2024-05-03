import 'package:hive/hive.dart';

import '../../domain/entity/hobby.dart';

part 'hobby_model.g.dart';

@HiveType(typeId: 12)
class HobbyModel extends Hobby {
  const HobbyModel({required super.id, required super.name});

  factory HobbyModel.fromJson(Map<String, dynamic> json) {
    return HobbyModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory HobbyModel.fromEntity(Hobby hobby) {
    return HobbyModel(
      id: hobby.id,
      name: hobby.name,
    );
  }
}