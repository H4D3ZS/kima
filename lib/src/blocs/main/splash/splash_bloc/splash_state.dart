part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
}

class SplashStateInitial extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashStateLoading extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashStateSuccess extends SplashState {
  @override
  List<Object> get props => [];
}

class SplashStateFailed extends SplashState {
  @override
  List<Object> get props => [];
}
