import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';

class SplashButtons extends StatelessWidget {
  final Function() onGetStartedPressed;
  final Function() onLearnMorePressed;

  const SplashButtons({
    super.key,
    required this.onGetStartedPressed,
    required this.onLearnMorePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton.white(
          label: 'Get Started',
          onPressed: onGetStartedPressed,
        ),
        const SizedBox(height: 20.0),
        CustomButton.green(
          label: 'Learn More',
          onPressed: onLearnMorePressed,
          borderColor: const Color(0xFFFFFFFF),
        ),
      ],
    );
  }
}
