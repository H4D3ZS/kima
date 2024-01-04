import 'package:flutter/material.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/screens/dashboard/widgets/dashboard_post/dashboard_post_card.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ProfileVisitFeed extends StatelessWidget {
  final UserProfile user;

  const ProfileVisitFeed(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 15.0, 0.0, 15.0),
              child: CustomText('${user.firstName}\'s Feed', fontWeight: FontWeight.w400),
            ),
            ListView.separated(
              itemCount: 1,
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: 10.0),
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (_, index) => const VerticalSpace(10.0),
              itemBuilder: (context, index) => DashboardPostCard(
                // TODO: Replace with proper type checking. This is currently for UI purposes only
                type: Post.classifieds,
                images: feedMockList[index],
              ),
            ),
          ],
        ),
      );
}
