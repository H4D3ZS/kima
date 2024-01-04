import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class NotificationTile extends StatelessWidget {
  const NotificationTile(this.notification, {Key? key}) : super(key: key);

  final NotificationEnum notification;

  @override
  Widget build(BuildContext context) => Container(
        constraints: BoxConstraints(minHeight: 60.0, maxWidth: MediaQuery.of(context).size.width),
        padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
        decoration: notification == NotificationEnum.unread
            ? BoxDecoration(color: AppColors.green.withOpacity(0.08))
            : const BoxDecoration(
                border: Border.symmetric(
                  horizontal: BorderSide(
                    color: AppColors.lightGrey20,
                  ),
                ),
              ),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/temporary/img_temp_2.jpeg',
                width: 40.0,
                height: 40.0,
                fit: BoxFit.cover,
              ),
            ),
            const HorizontalSpace(10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Sonamgrapher',
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: ' favorite your post.',
                          style: GoogleFonts.poppins(
                            height: 1.0,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const VerticalSpace(3.0),
                  CustomText(
                    '10 hours ago',
                    style: GoogleFonts.poppins(
                      height: 1.0,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightGrey,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {},
              child: Assets.icons.moreHorizontal.svg(),
            ),
          ],
        ),
      );
}
