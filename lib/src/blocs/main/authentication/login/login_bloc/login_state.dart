part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginStateInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginStateLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginStateSuccess extends LoginState {
  final UserProfile user;

  const LoginStateSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class LoginStateFailed extends LoginState {
  final Failure failure;

  const LoginStateFailed(
    this.failure,
  );

  @override
  List<Object> get props => [
        failure,
      ];
}
