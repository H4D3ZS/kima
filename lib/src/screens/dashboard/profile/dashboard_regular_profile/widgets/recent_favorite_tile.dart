import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class RecentFavoriteTile extends StatelessWidget {
  const RecentFavoriteTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  'Events',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey,
                ),
                CustomText(
                  'The Meemaw Materialization',
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500,
                ),
                CustomText(
                  'Post author',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey,
                ),
              ],
            ),
            Container(
              width: 80.0,
              height: 80.0,
              decoration: const BoxDecoration(
                color: AppColors.lightGrey5,
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                image: DecorationImage(
                  image: AssetImage('assets/temporary/img_temp_3.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      );
}
