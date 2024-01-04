import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/feed/feed_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/dashboard/dashboard_screen.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/widgets/business_cover_photo.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/widgets/business_details.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/widgets/business_intro.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/widgets/business_profile_feed.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/widgets/daily_status.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class DashboardBusinessProfileScreen extends StatefulWidget {
  const DashboardBusinessProfileScreen({Key? key}) : super(key: key);

  static const route = '/dashboard/business-profile';

  @override
  State<DashboardBusinessProfileScreen> createState() => _DashboardBusinessProfileScreenState();
}

class _DashboardBusinessProfileScreenState extends State<DashboardBusinessProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<FeedBloc>(context).add(GetProfileFeedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          BlocProvider.of<UserBloc>(context).state.user!.displayName,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.1,
        toolbarHeight: 95.0,
        leadingWidth: 110.0,
        leading: CircularIconButton(
          icon: Assets.icons.iconArrowLeft.svg(),
          bgColor: AppColors.lightGrey20,
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          onTap: () => switchViewCubit.selectedRoute(DashboardScreen.route),
        ),
        actions: [
          CircularIconButton(
            icon: Assets.icons.search2.svg(),
            bgColor: AppColors.lightGrey20,
            width: 50.0,
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            onTap: () {},
          ),
        ],
      ),
      backgroundColor: AppColors.lightGrey20,
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BusinessCoverPhoto(),
            BusinessIntro(),
            DailyStatus(),
            BusinessDetails(),
            BusinessProfileFeed(),
          ],
        ),
      ),
    );
  }
}
