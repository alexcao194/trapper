import 'package:equatable/equatable.dart';

class ConnectData extends Equatable {
  final int minAge;
  final int maxAge;
  final bool gender;
  final List<String> hobbies;

  const ConnectData({
    required this.minAge,
    required this.maxAge,
    required this.gender,
    required this.hobbies
  });

  ConnectData copyWith({
    int? minAge,
    int? maxAge,
    bool? gender,
    List<String>? hobbies,
  }) {
    return ConnectData(
        minAge: minAge ?? this.minAge,
        maxAge: maxAge ?? this.maxAge,
        gender: gender ?? this.gender,
        hobbies: hobbies ?? this.hobbies
    );
  }

  @override
  List<Object?> get props => [minAge, maxAge, gender, hobbies];
}