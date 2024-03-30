import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'profile.g.dart';

@HiveType(typeId: 0)
class Profile extends Equatable {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? photoUrl;
  @HiveField(3)
  final bool? gender;
  @HiveField(4)
  final String? birthDate;

  const Profile({this.name, this.email, this.photoUrl, this.gender, this.birthDate});

  @override
  String toString() {
    return "Profile(name: $name, email: $email,photoUrl: $photoUrl, gender: $gender, birthDate: $birthDate)";
  }

  @override
  List<Object?> get props => [name, email, photoUrl, gender, birthDate];

  Profile copyWith({
    String? name,
    String? email,
    String? photoUrl,
    bool? gender,
    String? birthDate,
  }) {
    return Profile(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
    );
  }
}
