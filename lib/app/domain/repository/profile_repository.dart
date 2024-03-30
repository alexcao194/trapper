import 'package:dartz/dartz.dart';
import 'package:trapper/core/failure/failure.dart';

import '../entity/profile.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Profile>> updateProfile(Profile profile);
  Future<Either<Failure, Profile>> getProfile();
}