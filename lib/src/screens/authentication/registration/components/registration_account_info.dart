import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kima/src/utils/widgets/customs/custom_intl_phone_field.dart';
import 'package:kima/src/utils/widgets/customs/custom_text_form_field.dart';

class RegistrationAccountInfo extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController contactController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmationController;
  final Function(String?)? onFirstNameChanged;
  final Function(String?)? onLastNameChanged;
  final Function(String?, bool) onContactChanged;
  final Function(String?)? onEmailChanged;
  final Function(String?)? onPasswordChanged;
  final Function(String?)? onPasswordConfirmationChanged;
  final String errorEmailText;
  final String errorPasswordMatchText;

  const RegistrationAccountInfo({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.contactController,
    required this.emailController,
    required this.passwordController,
    required this.passwordConfirmationController,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
    required this.onContactChanged,
    required this.onEmailChanged,
    required this.onPasswordChanged,
    required this.onPasswordConfirmationChanged,
    required this.errorEmailText,
    required this.errorPasswordMatchText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextFormField(
          controller: firstNameController,
          hint: 'First Name',
          onChanged: onFirstNameChanged,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))],
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 10.0),
        CustomTextFormField(
          controller: lastNameController,
          hint: 'Last Name',
          onChanged: onLastNameChanged,
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))],
          textCapitalization: TextCapitalization.words,
        ),
        const SizedBox(height: 10.0),
        CustomIntlPhoneField(onContactChanged: onContactChanged),
        const SizedBox(height: 10.0),
        CustomTextFormField(
          controller: emailController,
          hint: 'Email address',
          errorText: errorEmailText,
          onChanged: onEmailChanged,
        ),
        const SizedBox(height: 10.0),
        CustomTextFormField(
          controller: passwordController,
          hint: 'Password',
          obscure: true,
          canShow: true,
          onChanged: onPasswordChanged,
        ),
        const SizedBox(height: 10.0),
        CustomTextFormField(
          controller: passwordConfirmationController,
          hint: 'Confirm Password',
          obscure: true,
          canShow: true,
          errorText: errorPasswordMatchText,
          onChanged: onPasswordConfirmationChanged,
        ),
      ],
    );
  }
}
