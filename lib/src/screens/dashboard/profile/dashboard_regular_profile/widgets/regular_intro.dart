import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/dashboard/profile/edit_profile_screen.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_action_buttons.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/mixins.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class RegularIntro extends StatelessWidget with DialogMixins {
  final bool isViewOnly;

  const RegularIntro({
    this.isViewOnly = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userAccountBloc = BlocProvider.of<UserBloc>(context);
    final user = isViewOnly ? userAccountBloc.state.userVisit : userAccountBloc.state.user;

    return Padding(
      padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            user!.displayName,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
          const VerticalSpace(30.0),
          if (user.about?.isNotEmpty == true)
            CustomText(
              user.about!,
              fontWeight: FontWeight.w400,
              fontColor: AppColors.lightGrey,
            ),
          const VerticalSpace(30.0),
          ProfileActionButtons(
            leftBtnText: 'Share Profile',
            leftBtnIcon: Assets.icons.share.svg(colorFilter: Colors.white.toColorFilter),
            onTapLeftButton: () => showShareModalBottomSheet(context, user),
            rightBtnText: 'Edit Profile',
            rightBtnIcon: Assets.icons.edit.svg(),
            onTapRightButton: () => BlocProvider.of<SwitchViewCubit>(context).selectedRoute(EditProfileScreen.route),
          ),
        ],
      ),
    );
  }
}
