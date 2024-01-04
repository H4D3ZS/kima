import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: const Color(0xFFD92F58),
        content: CustomText(
          message,
          alignment: TextAlign.center,
          fontColor: const Color(0xFFFFFFFF),
        ),
      ),
    );
  }

  static show(
    BuildContext context,
    String message, {
    Color? backgroundColor,
    Color? textColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor ?? const Color(0xFF000000),
        content: CustomText(
          message,
          alignment: TextAlign.center,
          fontColor: textColor ?? const Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
