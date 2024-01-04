import 'package:flutter/material.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/screens/account/settings_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';

class ProfileActionButtons extends StatelessWidget {
  const ProfileActionButtons({
    Key? key,
    required this.leftBtnText,
    required this.rightBtnText,
    this.btnTextSize = 14.0,
    this.leftBtnColor,
    this.rightBtnColor,
    this.leftBtnBorderColor,
    this.rightBtnBorderColor,
    this.leftBtnIcon,
    this.rightBtnIcon,
    required this.onTapLeftButton,
    required this.onTapRightButton,
    this.onTapMoreButton,
  }) : super(key: key);

  final String leftBtnText;
  final String rightBtnText;
  final double btnTextSize;
  final Color? leftBtnColor;
  final Color? rightBtnColor;
  final Color? leftBtnBorderColor;
  final Color? rightBtnBorderColor;
  final Widget? leftBtnIcon;
  final Widget? rightBtnIcon;
  final VoidCallback onTapLeftButton;
  final VoidCallback onTapRightButton;
  final VoidCallback? onTapMoreButton;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: CustomButton.iconLabel(
              height: 40.0,
              label: leftBtnText,
              labelColor: Colors.white,
              fontSize: btnTextSize,
              fontWeight: FontWeight.w500,
              onPressed: onTapLeftButton,
              icon: leftBtnIcon,
              backgroundColor: leftBtnColor ?? AppColors.green,
              borderColor: leftBtnBorderColor,
              borderRadius: 4.0,
            ),
          ),
          const HorizontalSpace(15.0),
          Expanded(
            child: CustomButton.iconLabel(
              height: 40.0,
              label: rightBtnText,
              labelColor: rightBtnColor != null && rightBtnColor == Colors.white ? rightBtnBorderColor! : Colors.black,
              fontSize: btnTextSize,
              fontWeight: FontWeight.w500,
              onPressed: onTapRightButton,
              icon: rightBtnIcon,
              backgroundColor: rightBtnColor ?? AppColors.lightGrey20,
              borderColor: rightBtnBorderColor,
              borderRadius: 4.0,
            ),
          ),
          const HorizontalSpace(15.0),
          SizedBox(
            width: 50.0,
            height: 40.0,
            child: CustomButton.icon(
              onPressed: onTapMoreButton ??
                  () {
                    Navigator.pushNamed(
                      context,
                      SettingsScreen.route,
                    );
                  },
              icon: Assets.icons.moreHorizontal.svg(),
              backgroundColor: AppColors.lightGrey20,
            ),
          ),
        ],
      );
}
