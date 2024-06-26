import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:trapper/core/failure/failure.dart';

import '../entity/profile.dart';
import '../repository/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository _profileRepository;

  UpdateProfile({required ProfileRepository profileRepository}) : _profileRepository = profileRepository;

  Future<Either<Failure, Profile>> call(Profile profile, Uint8List? image) {

    if (profile.name == null) {
      return Future.value(Left(Failure('Name cannot be null')));
    }

    if (profile.name!.isEmpty) {
      return Future.value(Left(Failure('Name cannot be empty')));
    }

    return _profileRepository.updateProfile(profile, image);
  }
}