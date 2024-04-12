import 'package:hive/hive.dart';
import 'package:trapper/app/domain/entity/profile.dart';

part 'profile_model.g.dart';

@HiveType(typeId: 10)
class ProfileModel extends Profile {
  const ProfileModel({super.name, super.email, super.photoUrl, super.gender, super.birthDate, super.id, super.photos, super.bio});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    List<String?> photos = [];
    if (json['photos'] != null) {
      json['photos'].forEach((v) {
        photos.add(v as String?);
      });
    }
    return ProfileModel(
      name: json['full_name'] as String?,
      email: json['email'] as String?,
      photoUrl: json['photo_url'] as String?,
      gender: json['gender'] as bool?,
      birthDate: json['date_of_birth'] as String?,
      id: json['id'] as String?,
      bio: json['bio'] as String?,
      photos: photos,
    );
  }

  Map<String, dynamic> toJson() => {
    'full_name': name,
    'email': email,
    'photo_url': photoUrl,
    'gender': gender,
    'date_of_birth': birthDate,
    'id': id,
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