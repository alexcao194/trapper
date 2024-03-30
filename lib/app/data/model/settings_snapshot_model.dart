import 'package:hive_flutter/hive_flutter.dart';
import 'package:trapper/app/domain/entity/settings_snapshot.dart';

part 'settings_snapshot_model.g.dart';

@HiveType(typeId: 11)
class SettingsSnapshotModel extends SettingsSnapshot {
  const SettingsSnapshotModel({
    required super.red,
    required super.green,
    required super.blue,
    required super.themeIndex,
    required super.languageCode,
  });

  factory SettingsSnapshotModel.fromMap(Map<String, dynamic> map) {
    return SettingsSnapshotModel(
      red: map['red'],
      green: map['green'],
      blue: map['blue'],
      themeIndex: map['themeIndex'],
      languageCode: map['languageCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'red': red,
      'green': green,
      'blue': blue,
      'themeIndex': themeIndex,
      'languageCode': languageCode,
    };
  }
}
