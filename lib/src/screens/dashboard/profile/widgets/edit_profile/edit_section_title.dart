import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class EditSectionTitle extends StatelessWidget {
  const EditSectionTitle(
    this.title, {
    Key? key,
    required this.onTapEdit,
  }) : super(key: key);

  final String title;
  final VoidCallback onTapEdit;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          CustomText(
            'Edit',
            onPressed: onTapEdit,
            fontSize: 14.0,
            fontWeight: FontWeight.w500,
            fontColor: AppColors.powderBlue,
          )
        ],
      );
}
