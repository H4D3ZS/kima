import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ClassifiedsDescriptionBox extends StatelessWidget {
  const ClassifiedsDescriptionBox(this.description, {Key? key}) : super(key: key);

  final String? description;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const VerticalSpace(35.0),
          const CustomText(
            'Description',
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
          const VerticalSpace(15.0),
          CustomText(description!, fontWeight: FontWeight.w300),
        ],
      );
}
