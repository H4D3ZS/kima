import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';
import 'package:kima/src/utils/widgets/customs/custom_text_form_field.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const LabeledTextField({
    required this.label,
    this.hint = '',
    required this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            label,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.lightGrey10,
          ),
          const VerticalSpace(15.0),
          CustomTextFormField(
            controller: controller,
            hint: hint,
            borderColor: AppColors.lightGrey30,
            radius: 4.0,
          ),
        ],
      );
}
