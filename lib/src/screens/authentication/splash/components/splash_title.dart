import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class SplashTitle extends StatelessWidget {
  const SplashTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40.0),
        const CustomText(
          'Kima',
          fontColor: Color(0xFFFFFFFF),
          fontSize: 42.0,
          fontWeight: FontWeight.w800,
        ),
        const SizedBox(height: 20.0),
        const CustomText(
          'Schedule | Video | Payment',
          alignment: TextAlign.center,
          fontColor: Color(0xFFFFFFFF),
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
      ],
    );
  }
}
