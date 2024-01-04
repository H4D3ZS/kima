import 'package:flutter/material.dart';

class CustomCircularContainer extends StatelessWidget {
  final double? size;
  final Color? backgroundColor;
  final Widget? child;

  const CustomCircularContainer({
    super.key,
    this.size,
    this.backgroundColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 50.0,
      width: size ?? 50.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? const Color(0xFF757575),
      ),
      child: child,
    );
  }
}
