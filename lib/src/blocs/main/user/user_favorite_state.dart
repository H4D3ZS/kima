part of 'user_favorite_bloc.dart';

class UserFavoriteState extends Equatable {
  final Status status;
  final List<UserProfile>? favoriteUsers;
  final Failure? error;

  const UserFavoriteState({
    required this.status,
    this.favoriteUsers,
    this.error,
  });

  @override
  List<Object?> get props => [status, favoriteUsers, error];

  UserFavoriteState copyWith({
    Status? status,
    List<UserProfile>? favoriteUsers,
    Failure? error,
  }) =>
      UserFavoriteState(
        status: status ?? this.status,
        favoriteUsers: favoriteUsers ?? this.favoriteUsers,
        error: error ?? this.error,
      );

  bool isFavoriteUser(String id) =>
      favoriteUsers?.firstWhere((user) => user.id == id, orElse: () => const UserProfile()).id != null;
}
