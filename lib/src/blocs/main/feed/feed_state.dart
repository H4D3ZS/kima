part of 'feed_bloc.dart';

enum FeedStatus {
  initial,
  dashboardLoading,
  profileLoading,
  dashboardSuccess,
  profileSuccess,
  dashboardError,
  profileError,
}

class FeedState extends Equatable {
  final FeedStatus? status;
  final List<FeedPost>? profileFeed;
  final List<FeedPost>? dashboardFeed;
  final Failure? error;

  const FeedState({
    this.status,
    this.profileFeed,
    this.dashboardFeed,
    this.error,
  });

  @override
  List<Object?> get props => [status, dashboardFeed, profileFeed, error];

  FeedState copyWith({
    FeedStatus? status,
    List<FeedPost>? profileFeed,
    List<FeedPost>? dashboardFeed,
    Failure? error,
  }) =>
      FeedState(
        status: status ?? this.status,
        profileFeed: profileFeed ?? this.profileFeed,
        dashboardFeed: dashboardFeed ?? this.dashboardFeed,
        error: error ?? this.error,
      );
}
