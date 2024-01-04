import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/app_bottom_nav_cubit.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/feed/feed_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/classifieds/classifieds_screen.dart';
import 'package:kima/src/screens/dashboard/notifications/notifications_screen.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/dashboard_business_profile_screen.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_regular_profile/dashboard_regular_profile_screen.dart';
import 'package:kima/src/screens/dashboard/widgets/dashboard_business_title.dart';
import 'package:kima/src/screens/dashboard/widgets/dashboard_favorites.dart';
import 'package:kima/src/screens/dashboard/widgets/dashboard_feed.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_avatar.dart';
import 'package:kima/src/screens/favorites/favorites_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const route = '/dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    BlocProvider.of<FeedBloc>(context).add(GetDashboardFeedEvent());
    super.initState();
  }

  void _onSeeMorePressed() {}

  @override
  Widget build(BuildContext context) {
    final switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);
    final user = BlocProvider.of<UserBloc>(context).state.user!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: const Color(0xFFC3C3D1).withOpacity(0.25),
        toolbarHeight: 95.0,
        leadingWidth: MediaQuery.of(context).size.width * 0.7,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: user.isBusinessOrProfessionalUser
              ? Row(
                  children: [
                    CircularIconButton(
                      icon: Assets.icons.iconPlus.svg(colorFilter: Colors.white.toColorFilter),
                      height: 50.0,
                      width: 50.0,
                      bgColor: AppColors.green,
                      onTap: () {
                        Navigator.pushNamed(context, ClassifiedsScreen.route);
                      },
                    ),
                    HorizontalSpace(MediaQuery.of(context).size.width * 0.25),
                    InkWell(
                      onTap: () => switchViewCubit.selectedRoute(DashboardBusinessProfileScreen.route),
                      child: const ProfileAvatar(size: 50.0),
                    ),
                  ],
                )
              : CircularAvatarName(
                  onTapAvatar: () => switchViewCubit.selectedRoute(DashboardRegularProfileScreen.route),
                  title: 'Welcome',
                  titleStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.0,
                    color: AppColors.lightGrey10,
                  ),
                  subtitle: user.displayName,
                  subtitleStyle: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                  ),
                ),
        ),
        actions: [
          CircularIconButton(
            // If hasUnreadNotifications, else Assets.icons.bell.svg()
            icon: Assets.icons.bellWithNotif.svg(),
            onTap: () => switchViewCubit.selectedRoute(NotificationsScreen.route),
            bgColor: AppColors.green.withOpacity(0.12),
            margin: const EdgeInsets.only(right: 30.0),
            height: 50.0,
            width: 50.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user.isBusinessOrProfessionalUser) const DashboardBusinessTitle(),
            DashboardFavorites(onSeeMorePressed: () {
              BlocProvider.of<AppBottomNavCubit>(context).emitBottomNav(BottomNavEnum.favorite);
              switchViewCubit.selectedRoute(FavoritesScreen.route);
            }),
            const DashboardFeed(),
          ],
        ),
      ),
    );
  }
}
