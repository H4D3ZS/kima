part of 'report_bloc.dart';

class ReportState extends Equatable {
  final Status? status;
  final Failure? error;
  final ReportType? type;
  final Report? report;

  const ReportState({
    this.status,
    this.error,
    this.type,
    this.report,
  });

  @override
  List<Object?> get props => [status, error, type, report];

  ReportState copyWith({
    Status? status,
    Failure? error,
    ReportType? type,
    Report? report,
  }) =>
      ReportState(
        status: status ?? this.status,
        error: error ?? this.error,
        type: type ?? this.type,
        report: report ?? this.report,
      );
}
