part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class ProfileEventSaveChanges extends ProfileEvent {
  final UserProfile profile;

  const ProfileEventSaveChanges({
    required this.profile,
  });

  @override
  List<Object> get props => [profile];
}

class ProfileEventSaveAvatar extends ProfileEvent {
  final File avatar;

  const ProfileEventSaveAvatar({required this.avatar});

  @override
  List<Object> get props => [avatar];
}
