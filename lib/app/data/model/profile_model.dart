import 'package:hive/hive.dart';


import '../../../config/dio/dio_tools.dart';
import '../../domain/entity/hobby.dart';
import '../../domain/entity/profile.dart';
import 'hobby_model.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 10)
class ProfileModel extends Profile {
  const ProfileModel({super.name, super.email, super.photoUrl, super.gender, super.birthDate, super.id, super.photos, super.bio, super.hobbies = const []});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    List<String?> photos = List.filled(6, null);
    if (json['photos'] != null) {
      json['photos'].forEach((v) {
        var index = int.parse((v as String).split('/').last.split('-').first);
        photos[index] = "${DioTools.baseUrl}/$v";
      });
    }
    var photoUrl = json['photo_url'] as String?;
    if (photoUrl != null) {
      photoUrl = "${DioTools.baseUrl}/$photoUrl";
    }
    List<HobbyModel> hobbies = [];
    if (json['hobbies'] != null) {
      json['hobbies'].forEach((v) {
        hobbies.add(HobbyModel.fromJson(v));
      });
    }
    return ProfileModel(
      name: json['full_name'] as String?,
      email: json['email'] as String?,
      photoUrl: photoUrl,
      gender: json['gender'] == "true",
      birthDate: json['date_of_birth'] as String?,
      id: json['_id'] as String?,
      bio: json['bio'] as String?,
      photos: photos,
      hobbies: hobbies,
    );
  }

  Map<String, dynamic> toJson() => {
    'full_name': name,
    'email': email,
    'photo_url': photoUrl,
    'gender': gender,
    'date_of_birth': birthDate,
    '_id': id,
    'bio': bio,
    'photos': photos,
  };

  factory ProfileModel.fromEntity(Profile profile) {
    return ProfileModel(
        name: profile.name,
        email: profile.email,
        photoUrl: profile.photoUrl,
        gender: profile.gender,
        birthDate: profile.birthDate,
        id: profile.id,
        bio: profile.bio,
        photos: profile.photos
    );
  }
}