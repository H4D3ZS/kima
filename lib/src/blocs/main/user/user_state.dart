part of 'user_bloc.dart';

class UserState extends Equatable {
  final Status? status;
  final PhotoStatus? photoStatus;
  final UserProfile? user;
  final Failure? error;
  final UserProfile? userVisit;

  const UserState({
    this.status,
    this.photoStatus,
    this.user,
    this.error,
    this.userVisit,
  });

  @override
  List<Object?> get props => [
        status,
        photoStatus,
        user,
        error,
        userVisit,
      ];

  UserState copyWith({
    Status? status,
    PhotoStatus? photoStatus,
    Failure? error,
    UserProfile? user,
    UserProfile? userVisit,
  }) {
    return UserState(
      status: status ?? this.status,
      photoStatus: photoStatus ?? this.photoStatus,
      error: error ?? this.error,
      user: user ?? this.user,
      userVisit: userVisit ?? this.userVisit,
    );
  }
}
