import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:equatable/equatable.dart';
import 'package:kima/src/data/models/report.dart';
import 'package:kima/src/data/services/report_service.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/exceptions/api_result_exception.dart';
import 'package:kima/src/utils/failures/failure.dart';
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';

part 'report_event.dart';
part 'report_state.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  ReportBloc() : super(const ReportState(status: Status.initial)) {
    on<ReportTypeEvent>(_reportType);
    on<ReportUserEvent>(_reportUser);
    on<ReportClassifiedsEvent>(_reportClassifieds);
  }

  final _chopper = ChopperClient(
    baseUrl: Uri.parse(baseUrlDev),
    converter: const JsonConverter(),
    services: [ReportService.create()],
  );

  @override
  Future close() {
    _chopper.dispose();
    return super.close();
  }

  void _reportType(ReportTypeEvent event, emit) => emit(state.copyWith(type: event.type));

  Future<void> _reportUser(ReportUserEvent event, emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final token = await readStringSharedPref(spProfileJwt);

      final response = await _chopper.getService<ReportService>().reportUser(
            token: token!,
            body: event.report.toJson(),
          );

      if (!response.isSuccessful) throw ApiResultException(message: json.decode(response.bodyString)['message']);

      final report = Report.fromJson(response.body['data']);

      emit(state.copyWith(
        status: Status.success,
        report: report,
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

  Future<void> _reportClassifieds(ReportClassifiedsEvent event, emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final token = await readStringSharedPref(spProfileJwt);

      final response = await _chopper.getService<ReportService>().reportClassified(
            token: token!,
            body: event.report.toJson(),
          );

      if (!response.isSuccessful) throw ApiResultException(message: json.decode(response.bodyString)['message']);

      final report = Report.fromJson(response.body['data']);

      emit(state.copyWith(
        status: Status.success,
        report: report,
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
}
