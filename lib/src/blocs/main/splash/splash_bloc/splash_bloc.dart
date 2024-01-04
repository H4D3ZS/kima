import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'splash_event.dart';

part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashStateInitial()) {
    on<SplashEventCheck>(_onEventCheck);
  }

  Future<void> _onEventCheck(
    SplashEventCheck event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 6));

    emit(SplashStateSuccess());
  }
}
