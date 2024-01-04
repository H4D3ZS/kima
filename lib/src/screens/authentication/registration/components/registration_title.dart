import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class RegistrationTitle extends StatelessWidget {
  const RegistrationTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomText(
      'Create Account',
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
    );
  }
}
