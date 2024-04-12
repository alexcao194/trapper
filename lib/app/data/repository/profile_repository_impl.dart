import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:trapper/app/data/data_source/local_data.dart';
import 'package:trapper/app/data/model/profile_model.dart';
import 'package:trapper/app/domain/entity/hobby.dart';
import 'package:trapper/app/domain/entity/settings_snapshot.dart';

import '../../../core/failure/failure.dart';
import '../../domain/entity/profile.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/remote_data.dart';
import '../model/settings_snapshot_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final LocalData _localData;
  final RemoteData _remoteData;

  ProfileRepositoryImpl({required LocalData localData, required RemoteData remoteData})
      : _localData = localData,
        _remoteData = remoteData;

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    try {
      final profile = await _remoteData.getProfile();
      return Right(profile);
    } on Exception {
      var profile = await _remoteData.getProfile();
      return Right(profile);
    }
  }

  @override
  Future<Either<Failure, Profile>> updateProfile(Profile profile, Uint8List? image) async {
    try {
      var profileRes = await _remoteData.updateProfile(ProfileModel.fromEntity(profile), image);
      await _localData.saveProfile(ProfileModel.fromEntity(profile));
      return Right(profileRes);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SettingsSnapshot>> fetchSettings() async {
    try {
      final settings = await _localData.getSettingsSnapshot();
      return Right(settings);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, SettingsSnapshot>> updateSettings(SettingsSnapshot settings) async {
    try {
      await _localData.saveSettingsSnapshot(SettingsSnapshotModel.fromEntity(settings));
      return Right(settings);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Hobby>>> getHobbies() async {
    try {
      final hobbies = await _remoteData.getHobbies();
      return Right(hobbies);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<String?>>> postPhoto({required Uint8List image, required int index}) async {
    try {
      final photos = await _remoteData.postPhoto(image: image, index: index);
      return Right(photos);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
