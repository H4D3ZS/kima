import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? label;
  final Function() onPressed;
  final Color labelColor;
  final Color backgroundColor;
  final Color? borderColor;
  final Color disabledLabelColor;
  final Color disabledBackgroundColor;
  final bool enable;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? fontSize;
  final FontWeight? fontWeight;
  final bool withRadius;
  final Widget? icon;

  const CustomButton.white({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelColor = const Color(0xFF000000),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.disabledLabelColor = const Color(0xFFFFFFFF),
    this.disabledBackgroundColor = const Color(0xFFEAEAEA),
    this.borderColor = const Color(0xFF000000),
    this.enable = true,
    this.withRadius = true,
    this.height,
    this.width,
    this.borderRadius,
    this.icon,
    this.fontSize,
    this.fontWeight,
  });

  const CustomButton.green({
    super.key,
    required this.label,
    required this.onPressed,
    this.labelColor = const Color(0xFFFFFFFF),
    this.backgroundColor = const Color(0xFF38CC96),
    this.disabledLabelColor = const Color(0xFFFFFFFF),
    this.disabledBackgroundColor = const Color(0xFFEAEAEA),
    this.borderColor,
    this.enable = true,
    this.withRadius = true,
    this.height,
    this.width,
    this.borderRadius,
    this.icon,
    this.fontSize,
    this.fontWeight,
  });

  const CustomButton.icon({
    super.key,
    this.label,
    required this.icon,
    required this.onPressed,
    this.labelColor = const Color(0xFF757575),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.disabledLabelColor = const Color(0xFFFFFFFF),
    this.disabledBackgroundColor = const Color(0xFFEAEAEA),
    this.borderColor,
    this.enable = true,
    this.withRadius = true,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
  });

  const CustomButton.iconLabel({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.labelColor = const Color(0xFF757575),
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.disabledLabelColor = const Color(0xFFFFFFFF),
    this.disabledBackgroundColor = const Color(0xFFEAEAEA),
    this.borderColor,
    this.enable = true,
    this.withRadius = true,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    const defaultRadius = 8.0;

    return Container(
      height: height ?? 50.0,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
        color: enable ? backgroundColor : disabledBackgroundColor,
        border: Border.all(
          color: enable ? borderColor ?? backgroundColor : disabledBackgroundColor,
          width: 2.0,
        ),
      ),
      child: TextButton(
        onPressed: enable ? onPressed : null,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? defaultRadius),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && label != null) ...[
              icon!,
              const HorizontalSpace(10.0),
              CustomText(
                label!,
                fontColor: enable ? labelColor : disabledLabelColor,
                fontWeight: fontWeight ?? FontWeight.w500,
                fontSize: fontSize ?? 14.0,
              ),
            ],
            if (icon != null && label == null) icon!,
            if (icon == null && label != null)
              CustomText(
                label!,
                fontColor: enable ? labelColor : disabledLabelColor,
                fontWeight: fontWeight ?? FontWeight.w600,
                fontSize: fontSize ?? 18.0,
              ),
          ],
        ),
      ),
    );
  }
}
