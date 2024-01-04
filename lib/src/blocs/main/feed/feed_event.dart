part of 'feed_bloc.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();
}

class GetDashboardFeedEvent extends FeedEvent {
  @override
  List<Object?> get props => [];
}

class GetProfileFeedEvent extends FeedEvent {
  @override
  List<Object?> get props => [];
}
