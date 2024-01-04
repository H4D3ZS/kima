part of 'user_favorite_bloc.dart';

abstract class UserFavoriteEvent extends Equatable {}

class GetMyFavoriteUsersEvent extends UserFavoriteEvent {
  @override
  List<Object?> get props => [];
}
