part of 'registration_bloc.dart';

abstract class RegistrationState extends Equatable {
  const RegistrationState();
}

class RegistrationStateInitial extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationStateLoading extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationStateSuccess extends RegistrationState {
  @override
  List<Object> get props => [];
}

class RegistrationStateFailed extends RegistrationState {
  final Failure failure;

  const RegistrationStateFailed(this.failure);

  @override
  List<Object> get props => [failure];
}
