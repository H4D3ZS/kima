import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/app_bottom_nav_cubit.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/search_community/community_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/screens/search/profile_visit/profile_visit_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class SearchCardGridLayout extends StatefulWidget {
  final List<UserProfile> userList;
  final bool isLoadingMore;
  final int currentPage;
  final int totalPages;

  const SearchCardGridLayout(
    this.userList, {
    required this.isLoadingMore,
    required this.currentPage,
    required this.totalPages,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchCardGridLayout> createState() => _SearchCardGridLayoutState();
}

class _SearchCardGridLayoutState extends State<SearchCardGridLayout> {
  late CarouselController _controller;
  late int _currentIndex;

  @override
  void initState() {
    _controller = CarouselController();
    _currentIndex = 0;

    super.initState();
  }

  int get _userListCount => widget.userList.length;

  void _loadMoreAfterLastItem(int index) {
    final hasNextPage = widget.currentPage != widget.totalPages;

    if (index == _userListCount - 1 && hasNextPage) {
      BlocProvider.of<CommunityBloc>(context).add(GetAllCommunityEvent(
        isLoadMore: true,
        currentPage: widget.currentPage,
      ));
    }
    _currentIndex += 1;
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoadingMore
        ? Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.black10, AppColors.green],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.white5,
                  ),
                ),
              ),
            ],
          )
        : Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.black10, AppColors.green],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                height: MediaQuery.of(context).size.height,
                child: CarouselSlider.builder(
                  carouselController: _controller,
                  options: CarouselOptions(
                    height: double.infinity,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    initialPage: _currentIndex,
                    onPageChanged: (index, _) => _currentIndex = index,
                  ),
                  itemCount: _userListCount,
                  itemBuilder: (BuildContext context, int itemIndex, _) {
                    final user = widget.userList[itemIndex];

                    return Stack(
                      children: [
                        user.avatar != null
                            ? SizedBox(
                                height: double.infinity,
                                width: double.infinity,
                                child: Image.network(
                                  height: double.infinity,
                                  user.avatar!,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const SizedBox(),
                                  loadingBuilder: (_, Widget child, ImageChunkEvent? loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.white5,
                                        value: loadingProgress.expectedTotalBytes != null
                                            ? loadingProgress.cumulativeBytesLoaded /
                                                loadingProgress.expectedTotalBytes!
                                            : null,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [AppColors.black10, AppColors.green],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                                child: Center(
                                  child: CustomText(
                                    user.firstName![0].toUpperCase(),
                                    fontSize: 100.0,
                                    fontColor: Colors.white,
                                  ),
                                ),
                              ),
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
                            padding: const EdgeInsets.only(top: 10.0, bottom: 70.0),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.black10, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<UserBloc>(context).add(SetUserVisitEvent(user));
                                BlocProvider.of<AppBottomNavCubit>(context).emitBottomNav(BottomNavEnum.search);
                                BlocProvider.of<SwitchViewCubit>(context).selectedRoute(ProfileVisitScreen.route);
                              },
                              child: Column(
                                children: [
                                  CustomText(
                                    user.displayName,
                                    fontColor: Colors.white,
                                  ),
                                  CustomText(
                                    user.type!.toTitleCase(),
                                    fontColor: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _controller.animateToPage(_currentIndex - 1),
                        child: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Assets.svg.svgArrowLeft.svg(),
                          ),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          _controller.animateToPage(_currentIndex + 1);
                          _loadMoreAfterLastItem(_currentIndex);
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Assets.svg.svgArrowRight.svg(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
