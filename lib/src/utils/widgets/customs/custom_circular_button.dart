import 'package:flutter/material.dart';

class CustomCircularButton extends StatelessWidget {
  final Widget? child;
  final double? size;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final Function()? onPressed;

  const CustomCircularButton({
    super.key,
    this.child,
    this.size,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.backgroundColor,
    this.padding,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? const Color(0xFFEAEAEA),
      ),
      height: size,
      padding: padding ?? const EdgeInsets.all(10.0),
      width: size,
      child: InkWell(
        onTap: onPressed,
        child: child ??
            Icon(
              icon!,
              size: iconSize ?? 20.0,
              color: iconColor,
            ),
      ),
    );
  }
}
