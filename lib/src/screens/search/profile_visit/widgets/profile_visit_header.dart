import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_action_buttons.dart';
import 'package:kima/src/screens/search/profile_visit/profile_visit_settings_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ProfileVisitHeader extends StatelessWidget {
  final UserProfile user;

  const ProfileVisitHeader(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Column(
            children: [
              user.coverPhoto != null
                  ? Image.network(
                      user.coverUrl,
                      height: 200.0,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                    )
                  : Container(
                      width: double.infinity,
                      height: 200.0,
                      color: AppColors.lightGrey20,
                    ),
              Container(
                height: user.isBusinessOrProfessionalUser ? 220.0 : 190.0,
                color: Colors.white,
              ),
            ],
          ),
          Positioned(
            top: 120.0,
            left: 0.0,
            right: 0.0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white5,
                  border: Border.all(
                    color: Colors.white,
                    width: 5.0,
                  ),
                ),
                child: user.avatar != null
                    ? ClipOval(
                        child: Image.network(
                          user.avatarUrl,
                          width: 120.0,
                          height: 120.0,
                          fit: BoxFit.cover,
                        ),
                      )
                    : CircleAvatar(
                        radius: 60.0,
                        backgroundColor: AppColors.green,
                        child: CustomText(
                          user.firstName![0],
                          fontSize: 50.0,
                          fontWeight: FontWeight.w700,
                          fontColor: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
          Positioned(
            top: 270.0,
            left: 0.0,
            right: 0.0,
            child: CustomText(
              user.displayName,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              fontColor: Colors.black,
              alignment: TextAlign.center,
            ),
          ),
          if (user.isBusinessOrProfessionalUser)
            const Positioned(
              top: 300.0,
              left: 0.0,
              right: 0.0,
              child: CustomText(
                // TODO: Correct data mapping
                'Tech Company',
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
                fontColor: AppColors.lightGrey10,
                alignment: TextAlign.center,
              ),
            ),
          Positioned(
            bottom: 30.0,
            right: 30.0,
            left: 30.0,
            child: ProfileActionButtons(
              btnTextSize: 16.0,
              leftBtnText: 'Following',
              leftBtnColor: AppColors.primaryColor,
              onTapLeftButton: () {},
              rightBtnText: 'Message',
              rightBtnColor: Colors.white,
              rightBtnBorderColor: AppColors.primaryColor,
              onTapRightButton: () {},
              onTapMoreButton: () =>
                  BlocProvider.of<SwitchViewCubit>(context).selectedRoute(ProfileVisitSettingsScreen.route),
            ),
          ),
        ],
      );
}
