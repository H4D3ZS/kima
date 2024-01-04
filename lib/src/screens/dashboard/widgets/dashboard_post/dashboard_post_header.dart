import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_avatar.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class DashboardPostHeader extends StatelessWidget {
  const DashboardPostHeader({
    Key? key,
    required this.isCurrentUserPost,
    this.user,
    required this.postDate,
  }) : super(key: key);

  final bool isCurrentUserPost;
  final UserProfile? user;
  final String postDate;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 15.0),
        child: Row(
          children: [
            const ProfileAvatar(size: 40.0),
            const HorizontalSpace(15.0),
            CustomText(
              (isCurrentUserPost ? BlocProvider.of<UserBloc>(context).state.user?.displayName : user?.displayName) ??
                  '',
              fontWeight: FontWeight.w500,
            ),
            const HorizontalSpace(15.0),
            Expanded(
              child: CustomText(
                postDate,
                fontColor: AppColors.lightGrey8,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            CircularIconButton(
              width: 40.0,
              height: 40.0,
              bgColor: AppColors.lightGrey30,
              icon: Assets.icons.moreVertical.svg(),
              onTap: () {},
            ),
          ],
        ),
      );
}
