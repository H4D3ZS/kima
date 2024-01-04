import 'package:flutter/material.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        VerticalSpace(size.height * (size.height > 920.0 ? 0.1 : 0.06)),
        Image.asset(
          logoPngKimaTitle,
          height: size.height * 0.25,
          width: size.width * 0.60,
        ),
        const VerticalSpace(20.0),
        const CustomText(
          'Moving Mountains Together',
          alignment: TextAlign.center,
          fontColor: Color(0xFFFFFFFF),
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
        const VerticalSpace(50.0),
      ],
    );
  }
}
