import 'package:dartz/dartz.dart';
import 'package:trapper/core/failure/failure.dart';

import '../entity/profile.dart';
import '../repository/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository _profileRepository;

  UpdateProfile({required ProfileRepository profileRepository}) : _profileRepository = profileRepository;

  Future<Either<Failure, Profile>> call(Profile profile) {
    return _profileRepository.updateProfile(profile);
  }
}