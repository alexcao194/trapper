import 'package:equatable/equatable.dart';

class SettingsSnapshot extends Equatable {
  final int red;
  final int green;
  final int blue;

  final int themeIndex;

  final String languageCode;

  const SettingsSnapshot({
    required this.red,
    required this.green,
    required this.blue,
    required this.themeIndex,
    required this.languageCode,
  });

  @override
  List<Object?> get props => [red, green, blue, themeIndex, languageCode];
}