import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../entity/profile.dart';
import '../repository/profile_repository.dart';

class FetchFriends {
  final ProfileRepository _profileRepository;

  FetchFriends({required ProfileRepository profileRepository})
      : _profileRepository = profileRepository;

  Future<Either<Failure, List<Profile>>> call() {
    return _profileRepository.getFriends();
  }
}