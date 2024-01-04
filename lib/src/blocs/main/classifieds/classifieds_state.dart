part of 'classifieds_bloc.dart';

class ClassifiedsState extends Equatable {
  final Status? status;
  final Failure? error;
  final List<Classifieds>? classifiedsList;

  const ClassifiedsState({
    this.status,
    this.error,
    this.classifiedsList,
  });

  @override
  List<Object?> get props => [status, error, classifiedsList];

  ClassifiedsState copyWith({
    Status? status,
    Failure? error,
    Classifieds? classifiedAd,
    List<Classifieds>? classifiedsList,
  }) =>
      ClassifiedsState(
        status: status ?? this.status,
        error: error ?? this.error,
        classifiedsList: classifiedsList ?? this.classifiedsList,
      );
}
