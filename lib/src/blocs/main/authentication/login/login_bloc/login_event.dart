part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEventNative extends LoginEvent {
  final String email;
  final String password;

  const LoginEventNative({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}

class LoginEventSso extends LoginEvent {
  final SsoEnum sso;

  const LoginEventSso({required this.sso});

  @override
  List<Object> get props => [
        sso,
      ];
}

class LoginEventApple extends LoginEvent {
  @override
  List<Object> get props => [];
}
