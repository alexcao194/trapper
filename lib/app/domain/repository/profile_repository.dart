import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:trapper/app/domain/entity/settings_snapshot.dart';
import 'package:trapper/core/failure/failure.dart';

import '../entity/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> updateProfile(Profile profile, Uint8List? image);
  Future<Either<Failure, Profile>> getProfile();

  Future<Either<Failure, SettingsSnapshot>> fetchSettings();
  Future<Either<Failure, SettingsSnapshot>> updateSettings(SettingsSnapshot settings);
}