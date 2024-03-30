import 'package:dartz/dartz.dart';

import '../entity/profile.dart';
import '../repository/profile_repository.dart';

class GetProfile {
  final ProfileRepository _profileRepository;

  GetProfile({required ProfileRepository profileRepository}) : _profileRepository = profileRepository;

  Future<Either<Exception, Profile>> call() {
    return _profileRepository.getProfile();
  }
}