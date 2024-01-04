part of 'community_bloc.dart';

abstract class CommunityEvent extends Equatable {
  const CommunityEvent();
}

class GetAllCommunityEvent extends CommunityEvent {
  final bool isLoadMore;
  final int currentPage;

  const GetAllCommunityEvent({
    this.isLoadMore = false,
    this.currentPage = 1,
  });

  @override
  List<Object?> get props => [isLoadMore, currentPage];
}
