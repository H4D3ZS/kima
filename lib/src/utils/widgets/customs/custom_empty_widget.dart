import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(
        child: CustomText(
          'No content at the moment.',
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          fontColor: AppColors.lightGrey10,
        ),
      );
}
