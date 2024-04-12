import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../core/failure/failure.dart';
import '../repository/profile_repository.dart';

class PostPhoto {
  final ProfileRepository _repository;

  PostPhoto({required ProfileRepository repository}) : _repository = repository;

  Future<Either<Failure, List<String?>>> call({required Uint8List image, required int index}) async {
    return await _repository.postPhoto(image: image, index: index);
  }
}