import 'package:dartz/dartz.dart';
import 'package:trapper/app/domain/entity/settings_snapshot.dart';
import 'package:trapper/app/domain/repository/profile_repository.dart';
import 'package:trapper/core/failure/failure.dart';

class SaveSettings {
  final ProfileRepository _repository;

  SaveSettings({required ProfileRepository repository}) : _repository = repository;

  Future<Either<Failure, SettingsSnapshot>> call(SettingsSnapshot settings) {
    return _repository.updateSettings(settings);
  }
}