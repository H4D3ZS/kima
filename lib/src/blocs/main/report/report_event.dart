part of 'report_bloc.dart';

abstract class ReportEvent extends Equatable {
  const ReportEvent();
}

class ReportTypeEvent extends ReportEvent {
  final ReportType type;

  const ReportTypeEvent(this.type);

  @override
  List<Object?> get props => [type];
}

class ReportUserEvent extends ReportEvent {
  final Report report;

  const ReportUserEvent(this.report);

  @override
  List<Object?> get props => [report];
}

class ReportClassifiedsEvent extends ReportEvent {
  final Report report;

  const ReportClassifiedsEvent(this.report);

  @override
  List<Object?> get props => [report];
}
