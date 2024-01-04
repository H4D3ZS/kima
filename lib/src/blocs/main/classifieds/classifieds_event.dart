part of 'classifieds_bloc.dart';

abstract class ClassifiedsEvent extends Equatable {
  const ClassifiedsEvent();
}

class GetClassifiedsEvent extends ClassifiedsEvent {
  @override
  List<Object?> get props => [];
}

class CreateClassifiedsEvent extends ClassifiedsEvent {
  final Classifieds classifiedAd;
  final List<File>? gallery;

  const CreateClassifiedsEvent({required this.classifiedAd, this.gallery});

  @override
  List<Object?> get props => [classifiedAd, gallery];
}
