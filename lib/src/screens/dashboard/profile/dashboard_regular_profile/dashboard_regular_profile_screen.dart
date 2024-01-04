import 'package:flutter/material.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_regular_profile/widgets/recent_favorites.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_regular_profile/widgets/regular_cover_photo.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_regular_profile/widgets/regular_details.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_regular_profile/widgets/regular_intro.dart';

class DashboardRegularProfileScreen extends StatelessWidget {
  const DashboardRegularProfileScreen({Key? key}) : super(key: key);

  static const route = '/dashboard/regular-profile';

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RegularCoverPhoto(),
              RegularIntro(),
              RegularDetails(),
              RecentFavorites(),
            ],
          ),
        ),
      );
}
