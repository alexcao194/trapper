import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/data/model/profile_model.dart';
import '../../app/data/model/settings_snapshot_model.dart';
import '../../app/domain/entity/profile.dart';
import '../../app/domain/entity/settings_snapshot.dart';

class HiveTools {
  const HiveTools._();

  static const String _profileKey = 'profile';
  static const String _settingsSnapshotKey = 'settings_snapshot';

  static Box<ProfileModel> get profileBox => Hive.box<ProfileModel>(_profileKey);
  static Box<SettingsSnapshotModel> get settingsSnapshotBox => Hive.box<SettingsSnapshotModel>(_settingsSnapshotKey);

  static init() async {

    if (kIsWeb) {
      await Hive.initFlutter();
    } else {
      final dir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(dir.path);
    }

    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(SettingsSnapshotAdapter());
    Hive.registerAdapter(ProfileModelAdapter());
    Hive.registerAdapter(SettingsSnapshotModelAdapter());

    await Hive.openBox<ProfileModel>(_profileKey);
    await Hive.openBox<SettingsSnapshotModel>(_settingsSnapshotKey);
  }
}