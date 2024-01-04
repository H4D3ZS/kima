import 'package:bloc/bloc.dart';
import 'package:kima/src/utils/helpers/print_helpers.dart';

/// A [BlocObserver] that logs all [Bloc] events, state changes, and errors to the console.
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    // Logs the [event] for the [bloc] to the console.
    printDebug(event, title: '${bloc.runtimeType} onEvent');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // Logs the [change] for the [bloc] to the console.
    printDebug(change, title: '${bloc.runtimeType} onChange');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    // Logs the [transition] for the [bloc] to the console.
    printDebug(transition, title: '${bloc.runtimeType} onTransition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // Logs the [error] and [stackTrace] for the [bloc] to the console.
    printDebug(error, title: '${bloc.runtimeType} onError');
    printDebug(stackTrace, title: '${bloc.runtimeType} onError StackTrace');
  }
}
