class Profile {
  final String name;
  final String email;
  final String? photoUrl;
  final bool gender;
  final String birthDate;

  Profile({required this.name, required this.email, this.photoUrl, required this.gender, required this.birthDate});

  @override
  String toString() {
    return "Profile(name: $name, email: $email,photoUrl: $photoUrl, gender: $gender, birthDate: $birthDate)";
  }
}