import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ClassifiedsHeader extends StatelessWidget {
  const ClassifiedsHeader({
    Key? key,

    required this.category,
    required this.title,
    this.subtitle,
    required this.author,
    required this.listingDate,
  }) : super(key: key);

  final String category;
  final String title;
  final String? subtitle;
  final String author;
  final String listingDate;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              category.toUpperCase(),
              fontWeight: FontWeight.w400,
              fontColor: AppColors.green,
            ),
            const VerticalSpace(20.0),
            CustomText(
              title,
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
            ),
            if (subtitle?.isNotEmpty == true) ...[
              CustomText(
                subtitle!,
                fontColor: AppColors.lightGrey8,
                fontWeight: FontWeight.w400,
                fontSize: 18.0,
              ),
            ],
            const VerticalSpace(20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  'By $author',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey,
                ),
                CustomText(
                  'Listed $listingDate',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey,
                ),
              ],
            ),
          ],
        ),
      );
}
