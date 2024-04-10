import 'package:equatable/equatable.dart';

class ConnectData extends Equatable {
  final int minAge;
  final int maxAge;
  final int gender;
  final List<int> hobbies;

  const ConnectData({
    required this.minAge,
    required this.maxAge,
    required this.gender,
    required this.hobbies
  });

  ConnectData copyWith({
    int? minAge,
    int? maxAge,
    int? gender,
    List<int>? hobbies,
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