import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'settings_snapshot.g.dart';

@HiveType(typeId: 1)
class SettingsSnapshot extends Equatable {
  @HiveField(0)
  final int red;
  @HiveField(1)
  final int green;
  @HiveField(2)
  final int blue;
  @HiveField(3)
  final int themeIndex;
  @HiveField(4)
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