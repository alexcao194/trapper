part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object?> get props => [];
}

class ProfileGot extends ProfileState {
  final Profile profile;
  const ProfileGot(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileError extends ProfileState {
  final Exception exception;
  const ProfileError(this.exception);

  @override
  List<Object?> get props => [exception];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading();

  @override
  List<Object?> get props => [];
}