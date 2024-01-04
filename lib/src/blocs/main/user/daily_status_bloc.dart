import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:kima/src/data/models/daily_status.dart';
import 'package:kima/src/data/services/user_service.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/exceptions/api_result_exception.dart';
import 'package:kima/src/utils/failures/failure.dart';
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';

part 'daily_status_event.dart';
part 'daily_status_state.dart';

class DailyStatusBloc extends Bloc<DailyStatusEvent, DailyStatusState> {
  DailyStatusBloc() : super(const DailyStatusState(status: Status.initial)) {
    on<CreateDailyStatusEvent>(_createDailyStatus);
    on<GetCurrentStatusByIdEvent>(_getCurrentStatusById);
  }

  final _chopper = ChopperClient(
    baseUrl: Uri.parse(baseUrlDev),
    converter: const JsonConverter(),
    services: [UserService.create()],
  );

  @override
  Future close() {
    _chopper.dispose();
    return super.close();
  }

  Future<void> _createDailyStatus(CreateDailyStatusEvent event, emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final token = await readStringSharedPref(spProfileJwt);
      final body = {'statusContent': event.status};

      final response = await _chopper.getService<UserService>().createDailyStatus(token: token!, body: body);

      if (!response.isSuccessful) throw ApiResultException(message: json.decode(response.bodyString)['message']);

      final dailyStatus = DailyStatus.fromJson(response.body['data']);

      emit(state.copyWith(
        status: Status.success,
        dailyStatus: dailyStatus,
      ));
    } on ApiResultException catch (e) {
      final error = e.message;
      emit(
        state.copyWith(
          status: Status.failed,
          error: error != null ? Failure(message: error) : const Failure(),
        ),
      );
    }
  }

  Future<void> _getCurrentStatusById(GetCurrentStatusByIdEvent event, emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final token = await readStringSharedPref(spProfileJwt);

      Response<dynamic> response;
      if (event.id == null) {
        response = await _chopper.getService<UserService>().getAllDailyStatusById(token: token!);
      } else {
        response = await _chopper.getService<UserService>().getAllDailyStatusById(token: token!, id: event.id);
      }

      if (!response.isSuccessful) throw ApiResultException(message: json.decode(response.bodyString)['message']);

      final data = response.body['data'];
      final dailyStatusList = data.map<DailyStatus>((status) => DailyStatus.fromJson(status)).toList();

      /// Get recent status to display as the current status of the user
      final sortedDailyStatus = dailyStatusList
        ..sort((a, b) => DateTime.parse(b.createdAt).toLocal().compareTo(DateTime.parse(a.createdAt).toLocal()))
        ..toList();
      final dailyStatus = sortedDailyStatus[0];

      emit(
        state.copyWith(
          status: Status.success,
          dailyStatus: dailyStatus,
        ),
      );
    } on ApiResultException catch (e) {
      final error = e.message;
      emit(
        state.copyWith(
          status: Status.failed,
          error: error != null ? Failure(message: error) : const Failure(),
        ),
      );
    }
  }
}
