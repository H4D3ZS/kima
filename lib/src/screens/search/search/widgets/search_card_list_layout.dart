import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/search_community/community_bloc.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/screens/search/search/widgets/search_card.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class SearchCardListLayout extends StatefulWidget {
  final List<UserProfile> userList;
  final bool isLoadingMore;
  final int currentPage;
  final int totalPages;

  const SearchCardListLayout(
    this.userList, {
    required this.isLoadingMore,
    required this.currentPage,
    required this.totalPages,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchCardListLayout> createState() => _SearchCardListLayoutState();
}

class _SearchCardListLayoutState extends State<SearchCardListLayout> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(pagination);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void pagination() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && _hasNextPage) {
      BlocProvider.of<CommunityBloc>(context).add(GetAllCommunityEvent(
        isLoadMore: true,
        currentPage: widget.currentPage,
      ));
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 20.0);
    }
  }

  bool get _hasNextPage => widget.currentPage != widget.totalPages;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0, bottom: widget.isLoadingMore ? 20.0 : 0.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: widget.userList.length,
                itemBuilder: (context, index) {
                  final user = widget.userList[index];
                  return SearchCard(user);
                },
              ),
            ),
            if (widget.isLoadingMore) ...[
              const VerticalSpace(10.0),
              const CupertinoActivityIndicator(),
            ],
          ],
        ),
      );
}
