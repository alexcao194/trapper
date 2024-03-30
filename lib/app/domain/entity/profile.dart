import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String? name;
  final String? email;
  final String? photoUrl;
  final bool? gender;
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
