import 'package:trapper/app/domain/entity/profile.dart';

class ProfileModel extends Profile {
  ProfileModel({required super.name, required super.email, super.photoUrl, required super.gender, required super.birthDate});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      email: json['email'],
      photoUrl: json['photo_url'],
      gender: json['gender'],
      birthDate: json['birth_date'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'photo_url': photoUrl,
    'gender': gender,
    'birth_date': birthDate,
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