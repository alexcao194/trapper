import 'package:dartz/dartz.dart';

import '../entity/profile.dart';
import '../repository/profile_repository.dart';

class UpdateProfile {
  final ProfileRepository _profileRepository;

  UpdateProfile({required ProfileRepository profileRepository}) : _profileRepository = profileRepository;

  Future<Either<Exception, Profile>> call(Profile profile) {
    return _profileRepository.updateProfile(profile);
  }
}