import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/circular_profile_avatar.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class CircularAvatarName extends StatelessWidget {
  const CircularAvatarName({
    Key? key,
    required this.title,
    required this.subtitle,
    this.image,
    this.titleStyle,
    this.subtitleStyle,
    this.onTapAvatar,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String? image;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final VoidCallback? onTapAvatar;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          CircularProfileAvatar(onTap: onTapAvatar ?? () {}),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  title,
                  style: (titleStyle ??
                          GoogleFonts.poppins(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ))
                      .copyWith(height: 0.8),
                ),
                CustomText(
                  subtitle,
                  style: (subtitleStyle ??
                          GoogleFonts.poppins(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightGrey10,
                          ))
                      .copyWith(height: 1.4),
                ),
              ],
            ),
          ),
        ],
      );
}
