import 'package:hive_flutter/hive_flutter.dart';
import 'package:trapper/app/domain/entity/settings_snapshot.dart';

part 'settings_snapshot_model.g.dart';

@HiveType(typeId: 11)
class SettingsSnapshotModel extends SettingsSnapshot {
  const SettingsSnapshotModel({
    super.red = 0,
    super.green = 0,
    super.blue = 0,
    super.themeIndex = 0,
    super.languageCode = 'en',
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

  factory SettingsSnapshotModel.fromEntity(SettingsSnapshot entity) {
    return SettingsSnapshotModel(
      red: entity.red,
      green: entity.green,
      blue: entity.blue,
      themeIndex: entity.themeIndex,
      languageCode: entity.languageCode,
    );
  }
}
