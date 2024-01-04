import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class RegistrationButton extends StatelessWidget {
  final Function() onCreateAccountPressed;
  final Function() onGooglePressed;
  final Function() onFacebookPressed;
  final Function() onApplePressed;
  final bool enable;
  final bool isProfessionalOrBusiness;

  const RegistrationButton({
    super.key,
    required this.onCreateAccountPressed,
    required this.onGooglePressed,
    required this.onFacebookPressed,
    required this.onApplePressed,
    required this.enable,
    required this.isProfessionalOrBusiness,
  });


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton.green(
          label: isProfessionalOrBusiness ? 'Proceed to Payment' : 'Create Account',
          enable: enable,
          onPressed: onCreateAccountPressed,
        ),
        const SizedBox(height: 16.0),
        const Center(
          child: CustomText(
            'OR',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: CustomButton.icon(
                icon: Assets.icons.authentication.iconGoogle.image(),
                onPressed: onGooglePressed,
                borderColor: const Color(0xFFEBEBEB),
              ),
            ),
            if (Platform.isIOS) ...[
              const SizedBox(width: 20.0),
              Expanded(
                child: CustomButton.icon(
                  icon: Assets.icons.authentication.iconApple.image(),
                  onPressed: onApplePressed,
                  backgroundColor: const Color(0xFF000000),
                ),
              ),
            ],
            const SizedBox(width: 20.0),
            Expanded(
              child: CustomButton.icon(
                icon: Assets.icons.facebook.svg(),
                backgroundColor: const Color(0xFF3B5999),
                onPressed: onFacebookPressed,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
