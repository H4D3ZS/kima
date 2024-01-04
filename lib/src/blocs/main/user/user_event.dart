part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class SetCurrentUserEvent extends UserEvent {
  final UserProfile user;

  const SetCurrentUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class UpdateUserEvent extends UserEvent {
  final Map<String, dynamic> data;

  const UpdateUserEvent({required this.data});

  @override
  List<Object?> get props => [data];
}

class UploadUserPhotoEvent extends UserEvent {
  final String type;
  final ImageSource source;

  const UploadUserPhotoEvent({
    required this.type,
    required this.source,
  });

  @override
  List<Object?> get props => [type, source];
}

class GetUserVisitByIdEvent extends UserEvent {
  final String id;

  const GetUserVisitByIdEvent(this.id);

  @override
  List<Object?> get props => [id];
}

class SetUserVisitEvent extends UserEvent {
  final UserProfile user;

  const SetUserVisitEvent(this.user);

  @override
  List<Object?> get props => [user];
}
