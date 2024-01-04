import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class CustomIntlPhoneField extends StatelessWidget {
  final TextEditingController? controller;
  final String? completePhoneNumber;
  final Function(String?, bool) onContactChanged;
  final String hintText;

  const CustomIntlPhoneField({
    required this.onContactChanged,
    this.completePhoneNumber,
    this.hintText = '',
    this.controller,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final countryCode = completePhoneNumber != null ? PhoneNumber.getCountry(completePhoneNumber!) : null;

    return IntlPhoneField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      cursorColor: Colors.black,
      decoration: InputDecoration(
        counter: const SizedBox(),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color(0xFFEBEBEB),
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(
            color: Color(0xFFEBEBEB),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Color(0xFFEBEBEB)),
        ),
      ),
      initialCountryCode: countryCode?.code ?? WidgetsBinding.instance.platformDispatcher.locale.countryCode,
      controller: controller,
      onChanged: (phone) {
        final country = countries.firstWhere((element) => element.code == phone.countryISOCode);
        final isPhoneNumberValid = phone.number.length >= country.minLength && phone.number.length <= country.maxLength;
        onContactChanged(phone.completeNumber, isPhoneNumberValid);
      },
    );
  }
}
