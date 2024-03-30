part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileEventGet extends ProfileEvent {
  const ProfileEventGet();

  @override
  List<Object> get props => [];
}

class ProfileEventUpdate extends ProfileEvent {
  final Profile profile;

  const ProfileEventUpdate(this.profile);

  @override
  List<Object> get props => [profile];
}