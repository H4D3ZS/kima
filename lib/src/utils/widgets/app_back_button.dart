import 'package:flutter/material.dart';

class AppCircularBackButton extends StatelessWidget {
  final Function() onPressed;
  final IconData? icon;

  const AppCircularBackButton({
    super.key,
    required this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFEAEAEA),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: Container(
          margin: const EdgeInsets.all(8.0),
          child: Icon(
            icon ?? Icons.arrow_back,
            color: const Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}
