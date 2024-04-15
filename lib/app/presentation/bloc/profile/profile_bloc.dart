import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/entity/profile.dart';
import '../../../domain/use_case/get_profile.dart';
import '../../../domain/use_case/post_photo.dart';
import '../../../domain/use_case/update_profile.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late GetProfile _getProfile;
  late UpdateProfile _updateProfile;
  late PostPhoto _postPhoto;

  ProfileBloc({
    required GetProfile getProfile,
    required UpdateProfile updateProfile,
    required PostPhoto postPhoto,
  }) : super(const ProfileState(profile: Profile())) {
    _getProfile = getProfile;
    _updateProfile = updateProfile;
    _postPhoto = postPhoto;
    on<ProfileEventGet>(_onGet);
    on<ProfileEventUpdate>(_onUpdate);
    on<ProfileEventPostPhoto>(_onPostPhoto);
  }

  FutureOr<void> _onGet(ProfileEventGet event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true, sendMessage: false));
    final result = await _getProfile();
    result.fold(
      (exception) => emit(state.copyWith(message: exception.message, isLoading: false, sendMessage: true)),
      (profile) => emit(state.copyWith(profile: profile, isLoading: false, sendMessage: false)),
    );
  }

  FutureOr<void> _onUpdate(ProfileEventUpdate event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true, sendMessage: false));
    var profile = event.profile;

    if (profile.birthDate == null || profile.birthDate!.isEmpty) {
      profile = profile.copyWith(birthDate: state.profile.birthDate);
    }

    if (profile.name == null || profile.name!.isEmpty) {
      profile = profile.copyWith(name: state.profile.name);
    }

    if (profile.bio == null || profile.bio!.isEmpty) {
      profile = profile.copyWith(bio: state.profile.bio);
    }

    if (state.profile.name == profile.name && state.profile.birthDate == profile.birthDate && event.image == null && state.profile.bio == profile.bio) {
      emit(state.copyWith(message: S.current.nothing_to_update, isLoading: false, sendMessage: true));
      return;
    }

    final result = await _updateProfile(profile, event.image);
    result.fold(
      (exception) => emit(state.copyWith(message: exception.message, isLoading: false, sendMessage: true)),
      (profile) {
        emit(state.copyWith(profile: profile, message: S.current.profile_updated, isLoading: false, sendMessage: true));
      },
    );
  }

  FutureOr<void> _onPostPhoto(ProfileEventPostPhoto event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(isLoading: true, sendMessage: false));
    final result = await _postPhoto(
      image: event.image,
      index: event.index,
    );
    result.fold(
      (exception) => emit(state.copyWith(message: exception.message, isLoading: false, sendMessage: true)),
      (photos) => emit(
        state.copyWith(
          profile: state.profile.copyWith(
            photos: photos,
          ),
          isLoading: false,
          sendMessage: false,
        ),
      ),
    );
  }
}
