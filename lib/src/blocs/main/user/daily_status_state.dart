part of 'daily_status_bloc.dart';

class DailyStatusState extends Equatable {
  final Status? status;
  final DailyStatus? dailyStatus;
  final Failure? error;

  const DailyStatusState({
    this.status,
    this.dailyStatus,
    this.error,
  });

  @override
  List<Object?> get props => [status, dailyStatus, error];

  DailyStatusState copyWith({
    Status? status,
    DailyStatus? dailyStatus,
    Failure? error,
  }) =>
      DailyStatusState(
        status: status ?? this.status,
        dailyStatus: dailyStatus ?? this.dailyStatus,
        error: error ?? this.error,
      );
}
