part of 'daily_status_bloc.dart';

abstract class DailyStatusEvent extends Equatable {
  const DailyStatusEvent();
}

class CreateDailyStatusEvent extends DailyStatusEvent {
  final String status;

  const CreateDailyStatusEvent(this.status);

  @override
  List<Object?> get props => [status];
}

class GetCurrentStatusByIdEvent extends DailyStatusEvent {
  final String? id;

  const GetCurrentStatusByIdEvent({this.id});

  @override
  List<Object?> get props => [id];
}
