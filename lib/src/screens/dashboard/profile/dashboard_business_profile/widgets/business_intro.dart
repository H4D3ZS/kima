import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/classifieds/classifieds_screen.dart';
import 'package:kima/src/screens/dashboard/profile/edit_profile_screen.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_action_buttons.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class BusinessIntro extends StatelessWidget {
  const BusinessIntro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserBloc>(context).state.user;

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(30.0, 15.0, 30.0, 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            user!.displayName,
            style: GoogleFonts.comfortaa(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const VerticalSpace(5.0),
          const CustomText(
            // TODO: Nature of Business
            '',
            fontSize: 15.0,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.lightGrey10,
          ),
          const VerticalSpace(15.0),
          ProfileActionButtons(
            leftBtnText: 'Add Classifieds',
            leftBtnIcon: Assets.icons.iconPlus.svg(
              colorFilter: Colors.white.toColorFilter,
              width: 16.0,
            ),
            onTapLeftButton: () => {Navigator.pushNamed(context, ClassifiedsScreen.route)},
            rightBtnText: 'Edit Profile',
            rightBtnIcon: Assets.icons.edit.svg(),
            onTapRightButton: () => BlocProvider.of<SwitchViewCubit>(context).selectedRoute(EditProfileScreen.route),
          ),
        ],
      ),
    );
  }
}
