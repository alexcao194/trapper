import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../generated/assets.dart';
import '../model/profile_model.dart';
import '../model/settings_snapshot_model.dart';
import '../model/sticker_model.dart';

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

  List<StickerModel> getStickers();
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

  @override
  List<StickerModel> getStickers() {
    return <StickerModel>[
      StickerModel(url: Assets.stickerCat, slug: "cat meo mèo"),
      StickerModel(url: Assets.stickerCatGoodNight, slug: "cat good night meo chúc ngủ ngon chuc ngu ngon"),
      StickerModel(url: Assets.stickerCatHaha, slug: "cat haha meo cười cuoi"),
      StickerModel(url: Assets.stickerCatHug, slug: "cat hug meo ôm om"),
      StickerModel(url: Assets.stickerCatMucsic, slug: "cat music meo nhạc nhac"),
      StickerModel(url: Assets.stickerCatWithBox, slug: "cat with box meo hộp hop"),
      StickerModel(url: Assets.stickerCatWithHeart, slug: "cat with heart meo trái tim trai tim"),
      StickerModel(url: Assets.stickerDogAngry, slug: "dog angry chó giận gian tuc gian"),
      StickerModel(url: Assets.stickerDogDash, slug: "dog dash chó chạy chay"),
      StickerModel(url: Assets.stickerDogHello, slug: "dog hello chó xin chào xin chao"),
      StickerModel(url: Assets.stickerDogIMissYou, slug: "dog i miss you chó nhớ nhung nho"),
      StickerModel(url: Assets.stickerDogWhoa, slug: "dog whoa chó whoa"),
      StickerModel(url: Assets.stickerPersonHmm, slug: "person hmm người hmm"),
      StickerModel(url: Assets.stickerPersonRelax, slug: "person relax người thư giãn thu gian"),
    ];
  }
}