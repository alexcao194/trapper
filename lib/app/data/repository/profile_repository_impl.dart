import 'package:dartz/dartz.dart';
import 'package:trapper/app/data/data_source/local_data.dart';
import 'package:trapper/app/data/model/profile_model.dart';

import '../../../core/failure/failure.dart';
import '../../domain/entity/profile.dart';
import '../../domain/repository/profile_repository.dart';
import '../data_source/remote_data.dart';

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
  Future<Either<Failure, Profile>> updateProfile(Profile profile) async {
    try {
      await _remoteData.updateProfile(ProfileModel.fromEntity(profile));
      await _localData.saveProfile(ProfileModel.fromEntity(profile));
      return Right(profile);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
