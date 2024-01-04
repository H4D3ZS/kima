import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ClassifiedsItemDetail extends StatelessWidget {
  const ClassifiedsItemDetail({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.lightGrey5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              label,
              fontWeight: FontWeight.w400,
              fontColor: AppColors.lightGrey10,
            ),
            CustomText(value, fontWeight: FontWeight.w500),
          ],
        ),
      );
}
