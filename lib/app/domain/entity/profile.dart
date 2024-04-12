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
  @HiveField(5)
  final String? id;
  @HiveField(6)
  final List<String?>? photos;
  @HiveField(7)
  final String? bio;

  const Profile({this.name, this.email, this.photoUrl, this.gender, this.birthDate, this.id, this.bio, this.photos});

  @override
  String toString() {
    return "Profile(name: $name, email: $email,photoUrl: $photoUrl, gender: $gender, birthDate: $birthDate, id: $id, bio: $bio, photos: $photos)";
  }

  @override
  List<Object?> get props => [name, email, photoUrl, gender, birthDate, id, bio, photos];

  Profile copyWith({
    String? name,
    String? email,
    String? photoUrl,
    bool? gender,
    String? birthDate,
    String? id,
    String? bio,
    List<String?>? photos,
  }) {
    return Profile(
      name: name ?? this.name,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      gender: gender ?? this.gender,
      birthDate: birthDate ?? this.birthDate,
      id: id ?? this.id,
      bio: bio ?? this.bio,
      photos: photos ?? this.photos,
    );
  }
}
