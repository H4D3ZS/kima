import 'package:flutter/material.dart';

/// Icon With Circle Button Widget ---------------------------------------------
class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,
    required this.icon,
    this.bgColor = Colors.black,
    this.width = 37,
    this.height = 37,
    this.margin = EdgeInsets.zero,
    this.onTap,
    this.borderColor,
    this.borderWidth = 1.0,
  });

  final Widget icon;
  final Color bgColor;
  final double width;
  final double height;
  final double borderWidth;
  final EdgeInsets margin;
  final Function? onTap;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: GestureDetector(
        onTap: onTap as void Function()?,
        child: Container(
          padding: const EdgeInsets.all(2),
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: borderColor != null ? Border.all(color: borderColor!, width: borderWidth) : null,
          ),
          child: Center(child: icon),
        ),
      ),
    );
  }
}

/// Icon Button Widget ---------------------------------------------------------
