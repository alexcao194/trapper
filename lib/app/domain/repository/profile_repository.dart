import 'package:dartz/dartz.dart';

import '../entity/profile.dart';

abstract class ProfileRepository {
  Future<Either<Exception, Profile>> updateProfile(Profile profile);
  Future<Either<Exception, Profile>> getProfile();
}