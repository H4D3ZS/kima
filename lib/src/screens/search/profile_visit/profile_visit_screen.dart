import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/blocs/main/user/user_favorite_bloc.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/widgets/daily_status.dart';
import 'package:kima/src/screens/search/profile_visit/widgets/profile_visit_activity.dart';
import 'package:kima/src/screens/search/profile_visit/widgets/profile_visit_feed.dart';
import 'package:kima/src/screens/search/profile_visit/widgets/profile_visit_header.dart';
import 'package:kima/src/screens/search/profile_visit/widgets/profile_visit_social_media.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ProfileVisitScreen extends StatefulWidget {
  const ProfileVisitScreen({Key? key}) : super(key: key);

  static const route = '/profile-visit';

  @override
  State<ProfileVisitScreen> createState() => _ProfileVisitScreenState();
}

class _ProfileVisitScreenState extends State<ProfileVisitScreen> {
  @override
  void initState() {
    BlocProvider.of<UserFavoriteBloc>(context).add(GetMyFavoriteUsersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == Status.failed) {
          return Center(child: CustomText(state.error!.message));
        }
        final user = state.userVisit!;
        return Scaffold(
          backgroundColor: AppColors.lightGrey30,
          body: SingleChildScrollView(
            child: Column(
              children: [
                ProfileVisitHeader(user),
                if (user.isRegularUser) ProfileVisitActivity(user),
                if (user.isBusinessOrProfessionalUser) ...[
                  const DailyStatus(isEditable: false),
                  ProfileVisitSocialMedia(user),
                  ProfileVisitFeed(user),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
