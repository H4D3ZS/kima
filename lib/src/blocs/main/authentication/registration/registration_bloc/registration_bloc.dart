import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/data/services/authentication_service.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/failures/failure.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/exceptions/api_result_exception.dart';
import 'package:kima/src/utils/helpers/print_helpers.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationStateInitial()) {
    on<RegistrationEventNative>(_onEventNative);
  }

  final _chopper = ChopperClient(
    baseUrl: Uri.parse(baseUrlDev),
    converter: const JsonConverter(),
    services: [
      AuthenticationService.create(),
    ],
  );

  @override
  Future close() {
    _chopper.dispose();

    return super.close();
  }

  Future<void> _onEventNative(
    RegistrationEventNative event,
    Emitter<RegistrationState> emit,
  ) async {
    emit(RegistrationStateLoading());

    try {
      final registration = event.userProfile;

      final result = await _chopper.getService<AuthenticationService>().postRegistrationNative(
            type: event.userType.name,
            body: registration.toJson(),
          );

      if (!result.isSuccessful) {
        throw ApiResultException(message: json.decode(result.bodyString)['message']);
      }

      emit(RegistrationStateSuccess());
    } on ApiResultException catch (e) {
      final error = e.message;

      if (error != null) {
        emit(RegistrationStateFailed(Failure(message: error)));
      } else {
        emit(const RegistrationStateFailed(Failure()));
      }
    } catch (e, stackTrace) {
      printCatch(e, stackTrace, runtimeType);
      emit(const RegistrationStateFailed(Failure()));
    }
  }
}
