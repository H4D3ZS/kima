import 'package:flutter/material.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/screens/dashboard/notifications/widgets/notification_tile.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ProfileVisitActivity extends StatelessWidget {
  final UserProfile user;

  const ProfileVisitActivity(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(top: 10.0),
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.5),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30.0, 15.0, 0.0, 15.0),
              child: CustomText('${user.firstName}\'s Activity', fontWeight: FontWeight.w400),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) => const NotificationTile(NotificationEnum.read),
            ),
          ],
        ),
      );
}
