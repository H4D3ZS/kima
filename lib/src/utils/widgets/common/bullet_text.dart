import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class BulletText extends StatelessWidget {
  const BulletText(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 22.0,
        child: ListTile(
          leading: const CustomText('\u2022', fontWeight: FontWeight.bold),
          title: CustomText(text, fontWeight: FontWeight.w300),
          horizontalTitleGap: 0.0,
          minLeadingWidth: 22.0,
          dense: true,
          visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
          contentPadding: const EdgeInsets.only(left: 10.0),
        ),
      );
}
