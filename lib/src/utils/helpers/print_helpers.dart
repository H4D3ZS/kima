import 'package:flutter/foundation.dart';

/// Prints [object] to the console in debug mode with an optional [title].
void printDebug(Object? object, {String? title}) {
  if (kDebugMode) {
    if (title != null) {
      print('*** $title: $object ***');
    } else {
      print('*** $object ***');
    }
  }
}

/// Prints an error message to the console in debug mode along with the [stackTrace]
/// and the [runtimeType] of the object that threw the error.
void printCatch(Object? e, StackTrace stackTrace, Object runtimeType) {
  if (kDebugMode) {
    print('*** $runtimeType: $e ***');
    print('*** stackTrace: $stackTrace ***');
  }
}
