import 'package:trapper/app/domain/entity/hobby.dart';

class HobbyModel extends Hobby {
  HobbyModel({required super.id, required super.name});

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