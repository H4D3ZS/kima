part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileStateInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileStateLoading extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileStateSuccessEdit extends ProfileState {
  final UserProfile userProfile;

  const ProfileStateSuccessEdit({
    required this.userProfile,
  });

  @override
  List<Object> get props => [userProfile];
}

class ProfileStateSuccess extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileStateFailed extends ProfileState {
  final Failure failure;

  const ProfileStateFailed(
    this.failure,
  );

  @override
  List<Object> get props => [
        failure,
      ];
}
