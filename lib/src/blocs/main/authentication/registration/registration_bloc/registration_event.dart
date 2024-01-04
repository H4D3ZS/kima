part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegistrationEventNative extends RegistrationEvent {
  final UserProfile userProfile;
  final UserTypeEnum userType;

  const RegistrationEventNative({
    required this.userProfile,
    required this.userType,
  });

  @override
  List<Object> get props => [userProfile];
}
