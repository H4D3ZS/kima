import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends StatelessWidget {
  final String data;
  final TextStyle? style;
  final Function()? onPressed;

  ///Default: const Color(0xFF000000)
  final Color? fontColor;

  ///Default: 16.0
  final double? fontSize;

  ///Default: FontWeight.w600
  final FontWeight? fontWeight;
  final String? fontFamily;
  final TextAlign? alignment;
  final TextOverflow? overflow;

  const CustomText(
    this.data, {
    super.key,
    this.style,
    this.fontColor,
    this.fontSize,
    this.fontWeight,
    this.alignment,
    this.overflow,
    this.fontFamily,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(
        data,
        overflow: overflow,
        textAlign: alignment,
        style: style ??
            GoogleFonts.poppins(
              color: fontColor ?? const Color(0xFF000000),
              fontSize: fontSize ?? 16.0,
              fontWeight: fontWeight ?? FontWeight.w600,
            ),
      ),
    );
  }
}
