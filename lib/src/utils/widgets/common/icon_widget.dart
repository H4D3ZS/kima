import 'package:flutter/material.dart';

// TODO: Delete once migrated to use CircularIconButton. This is to utilize the generated icon assets
/// Icon With Circle Button Widget ---------------------------------------------
class IconWithCircleButton extends StatelessWidget {
  const IconWithCircleButton({
    super.key,
    required this.iconData,
    this.bgColor = Colors.black,
    this.iconColor = Colors.white,
    this.width = 37,
    this.height = 37,
    this.margin = EdgeInsets.zero,
    this.onTap,
  });

  final IconData iconData;
  final Color bgColor;
  final Color iconColor;
  final double width;
  final double height;
  final EdgeInsets margin;
  final Function? onTap;

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
          ),
          child: Center(
            child: Icon(
              iconData,
              color: iconColor,
              size: 24.0,
            ),
          ),
        ),
      ),
    );
  }
}

/// Icon Button Widget ---------------------------------------------------------
