import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/profile.dart';
import '../../../domain/use_case/get_profile.dart';
import '../../../domain/use_case/update_profile.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late GetProfile _getProfile;
  late UpdateProfile _updateProfile;

  ProfileBloc({
    required GetProfile getProfile,
    required UpdateProfile updateProfile,
  }) : super(const ProfileInitial()) {
    _getProfile = getProfile;
    _updateProfile = updateProfile;
    on<ProfileEventGet>(_onGet);
    on<ProfileEventUpdate>(_onUpdate);
  }

  FutureOr<void> _onGet(ProfileEventGet event, Emitter<ProfileState> emit) async {
    emit(const ProfileInitial());
    final result = await _getProfile();
    result.fold(
      (exception) => emit(ProfileError(exception)),
      (profile) => emit(ProfileGot(profile)),
    );
  }

  FutureOr<void> _onUpdate(ProfileEventUpdate event, Emitter<ProfileState> emit) {
    emit(const ProfileLoading());
    _updateProfile(event.profile).then((result) {
      result.fold(
        (exception) => emit(ProfileError(exception)),
        (profile) => emit(ProfileGot(profile)),
      );
    });
  }
}
