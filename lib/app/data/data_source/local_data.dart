import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trapper/app/data/model/profile_model.dart';
import 'package:trapper/app/data/model/settings_snapshot_model.dart';

abstract class LocalData {
  Future<void> saveToken(String token);
  Future<void> deleteToken();
  String getToken();

  Future<void> saveRefreshToken(String token);
  Future<void> deleteRefreshToken();
  String getRefreshToken();

  Future<ProfileModel> getProfile();
  Future<void> saveProfile(ProfileModel profile);

  Future<void> saveSettingsSnapshot(SettingsSnapshotModel settingsSnapshot);
  Future<SettingsSnapshotModel> getSettingsSnapshot();
}

class LocalDataImpl implements LocalData {
  final SharedPreferences _sharedPreferences;
  final Box<ProfileModel> _profileBox;
  final Box<SettingsSnapshotModel> _settingsSnapshotBox;

  static const String tokenKey = 'token';
  static const String refreshTokenKey = 'refreshToken';

  LocalDataImpl({required SharedPreferences sharedPreferences, required Box<ProfileModel> profileBox, required Box<SettingsSnapshotModel> settingsSnapshotBox})
      : _sharedPreferences = sharedPreferences,
        _profileBox = profileBox,
        _settingsSnapshotBox = settingsSnapshotBox;

  @override
  Future<void> deleteToken() async {
    await _sharedPreferences.remove(tokenKey);
  }

  @override
  String getToken() {
    return _sharedPreferences.getString(tokenKey) ?? '';
  }

  @override
  Future<void> saveToken(String token) async {
    await _sharedPreferences.setString(tokenKey, token);
  }

  @override
  Future<void> deleteRefreshToken() async {
    await _sharedPreferences.remove(refreshTokenKey);
  }

  @override
  String getRefreshToken() {
    return _sharedPreferences.getString(refreshTokenKey) ?? '';
  }

  @override
  Future<void> saveRefreshToken(String token) {
    return _sharedPreferences.setString(refreshTokenKey, token);
  }

  @override
  Future<ProfileModel> getProfile() async {
    return _profileBox.get('profile') ?? const ProfileModel();
  }

  @override
  Future<SettingsSnapshotModel> getSettingsSnapshot() async {
    return _settingsSnapshotBox.get('settingsSnapshot') ?? const SettingsSnapshotModel();
  }

  @override
  Future<void> saveProfile(ProfileModel profile) async {
    await _profileBox.put('profile', profile);
  }

  @override
  Future<void> saveSettingsSnapshot(SettingsSnapshotModel settingsSnapshot ) async {
    await _settingsSnapshotBox.put('settingsSnapshot', settingsSnapshot);
  }
}