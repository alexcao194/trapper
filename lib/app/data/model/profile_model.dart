import 'package:trapper/app/domain/entity/profile.dart';

class ProfileModel extends Profile {
  const ProfileModel({super.name, super.email, super.photoUrl, super.gender, super.birthDate});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['full_name'],
      email: json['email'],
      photoUrl: json['photo_url'],
      gender: json['gender'] == "true",
      birthDate: json['date_of_birth'],
    );
  }

  Map<String, dynamic> toJson() => {
    'full_name': name,
    'email': email,
    'photo_url': photoUrl,
    'gender': gender,
    'date_of_birth': birthDate,
  };

  factory ProfileModel.fromEntity(Profile profile) {
    return ProfileModel(
        name: profile.name,
        email: profile.email,
        photoUrl: profile.photoUrl,
        gender: profile.gender,
        birthDate: profile.birthDate,
    );
  }
}