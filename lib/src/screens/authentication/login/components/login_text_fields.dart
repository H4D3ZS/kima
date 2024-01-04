import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text_form_field.dart';

class LoginTextFields extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function(String?)? onEmailChanged;
  final Function(String?)? onPasswordChanged;

  const LoginTextFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.onEmailChanged,
    required this.onPasswordChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          height: 50.0,
          controller: emailController,
          hint: 'Enter Email',
          onChanged: onEmailChanged,
        ),
        const VerticalSpace(16.0),
        CustomTextFormField(
          height: 50.0,
          controller: passwordController,
          hint: 'Enter Password',
          obscure: true,
          canShow: true,
          onChanged: onPasswordChanged,
        ),
      ],
    );
  }
}
