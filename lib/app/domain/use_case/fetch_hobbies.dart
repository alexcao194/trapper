import 'package:dartz/dartz.dart';

import '../../../core/failure/failure.dart';
import '../entity/hobby.dart';
import '../repository/profile_repository.dart';
class FetchHobbies {
  late final ProfileRepository _profileRepository;

  FetchHobbies({required ProfileRepository profileRepository}) : _profileRepository = profileRepository;

  Future<Either<Failure, List<Hobby>>> call() async {
    return await _profileRepository.getHobbies();
  }
}