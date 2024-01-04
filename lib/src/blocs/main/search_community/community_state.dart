part of 'community_bloc.dart';

class CommunityState extends Equatable {
  final List<UserProfile>? users;
  final bool isInitialLoading;
  final bool isLoadingMore;
  final int? currentPage;
  final int? totalPages;
  final Failure? error;

  const CommunityState({
    this.users,
    this.isInitialLoading = true,
    this.isLoadingMore = false,
    this.currentPage,
    this.totalPages,
    this.error,
  });

  @override
  List<Object?> get props => [users, isInitialLoading, isLoadingMore, currentPage, totalPages, error];

  CommunityState copyWith({
    List<UserProfile>? users,
    bool? isLoadingMore,
    bool? isInitialLoading,
    int? currentPage,
    int? totalPages,
    Failure? error,
  }) {
    return CommunityState(
      users: users ?? this.users,
      isInitialLoading: isInitialLoading ?? this.isInitialLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      error: error ?? this.error,
    );
  }
}
