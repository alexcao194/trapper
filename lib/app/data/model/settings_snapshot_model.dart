import 'package:trapper/app/domain/entity/settings_snapshot.dart';

class SettingsSnapshotModel extends SettingsSnapshot {
  SettingsSnapshotModel({
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
