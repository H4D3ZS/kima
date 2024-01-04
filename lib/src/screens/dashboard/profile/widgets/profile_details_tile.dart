import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class ProfileDetailsTile extends StatelessWidget {
  const ProfileDetailsTile(
    this.text, {
    Key? key,
    required this.icon,
    this.onTap,
    this.isBusiness = true,
  }) : super(key: key);

  final String text;
  final Widget icon;
  final VoidCallback? onTap;
  final bool isBusiness;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap ?? () {},
        child: Row(
          children: [
            icon,
            const HorizontalSpace(15.0),
            if (icon == IconMap.dashboardProfileDetails[0].svg())
              RichText(
                text: TextSpan(
                  text: 'From  ',
                  style: GoogleFonts.poppins(
                    color: AppColors.black10,
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                  ),
                  children: [
                    TextSpan(
                      text: text,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              )
            else if (icon == IconMap.dashboardProfileDetails[1].svg())
              Text(
                'Joined $text',
                style: GoogleFonts.poppins(
                  color: AppColors.black10,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              )
            else
              Text(
                text,
                style: GoogleFonts.poppins(
                  color: isBusiness ? AppColors.black10 : AppColors.lightGrey10,
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
          ],
        ),
      );
}
