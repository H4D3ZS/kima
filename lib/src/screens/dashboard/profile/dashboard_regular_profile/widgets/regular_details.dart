import 'package:flutter/material.dart';
import 'package:kima/src/screens/account/edit_public_information/edit_about_info_screen.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_details_tile.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class RegularDetails extends StatelessWidget {
  const RegularDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border.symmetric(
            horizontal: BorderSide(
              width: 1.0,
              color: AppColors.lightGrey30,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              'Details',
              fontSize: 18.0,
              fontWeight: FontWeight.w400,
            ),
            const VerticalSpace(20.0),
            ProfileDetailsTile(
              'See your About info',
              isBusiness: false,
              onTap: () => Navigator.pushNamed(context, EditAboutInfoScreen.route),
              icon: IconMap.dashboardProfileDetails[4].svg(
                colorFilter: AppColors.lightGrey10.toColorFilter,
                width: 18.0,
                height: 18.0,
              ),
            ),
          ],
        ),
      );
}
