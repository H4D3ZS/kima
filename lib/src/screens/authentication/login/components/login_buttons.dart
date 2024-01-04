import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class LoginButtons extends StatelessWidget {
  final bool enableLogin;
  final Function() onPasswordRecoveryPressed;
  final Function() onLoginPressed;
  final Function() onSignUpPressed;
  final Function() onGooglePressed;
  final Function() onApplePressed;
  final Function() onFacebookPressed;

  const LoginButtons({
    super.key,
    required this.enableLogin,
    required this.onPasswordRecoveryPressed,
    required this.onLoginPressed,
    required this.onSignUpPressed,
    required this.onGooglePressed,
    required this.onApplePressed,
    required this.onFacebookPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const VerticalSpace(30.0),
        GestureDetector(
          onTap: onPasswordRecoveryPressed,
          child: const CustomText(
            'Forgot Password?',
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontColor: AppColors.black10,
          ),
        ),
        const VerticalSpace(30.0),
        CustomButton.green(
          height: 50.0,
          label: 'Login',
          enable: enableLogin,
          borderColor: const Color(0xFF7AE2A0),
          onPressed: onLoginPressed,
        ),
        const VerticalSpace(20.0),
        const Center(
          child: CustomText(
            'OR',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
        ),
        const VerticalSpace(20.0),
        Row(
          children: [
            Expanded(
              child: CustomButton.icon(
                icon: Assets.icons.googleLogo.image(scale: 2.0),
                onPressed: onGooglePressed,
              ),
            ),
            if (Platform.isIOS) ...[
              const SizedBox(width: 20.0),
              Expanded(
                child: CustomButton.icon(
                  icon: Assets.icons.logoApple.svg(),
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
        VerticalSpace(MediaQuery.of(context).size.height * 0.08),
        Center(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Don’t have account yet? ',
                ),
                TextSpan(
                  text: 'Sign Up',
                  recognizer: TapGestureRecognizer()..onTap = () => onSignUpPressed(),
                  style: const TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
