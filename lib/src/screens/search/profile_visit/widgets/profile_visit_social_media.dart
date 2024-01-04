import 'package:flutter/material.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ProfileVisitSocialMedia extends StatelessWidget {
  final UserProfile user;

  const ProfileVisitSocialMedia(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: MediaQuery.of(context).size.width,
        height: 96.0,
        color: Colors.white,
        margin: const EdgeInsets.only(top: 10.0),
        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText('Social Media', fontWeight: FontWeight.w400),
            const VerticalSpace(10.0),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 2,
                separatorBuilder: (BuildContext context, int index) => const HorizontalSpace(5.0),
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(5.5),
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryColor.withOpacity(0.12),
                  ),
                  child: Assets.icons.globe.svg(
                    width: 24.0,
                    height: 24.0,
                    colorFilter: AppColors.primaryColor.toColorFilter,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
