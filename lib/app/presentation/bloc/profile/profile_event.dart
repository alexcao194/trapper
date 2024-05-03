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
  final Uint8List? image;

  const ProfileEventUpdate(this.profile, {this.image});

  @override
  List<Object> get props => [profile, image ?? Uint8List(0)];
}

class ProfileEventPostPhoto extends ProfileEvent {
  final Uint8List image;
  final int index;

  const ProfileEventPostPhoto({required this.image, required this.index});

  @override
  List<Object> get props => [image, index];
}

class ProfileReset extends ProfileEvent {
  const ProfileReset();

  @override
  List<Object> get props => [];
}