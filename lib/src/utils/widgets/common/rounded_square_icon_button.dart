import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';

class RoundedSquareIconButton extends StatelessWidget {
  const RoundedSquareIconButton({
    Key? key,
    required this.icon,
    this.buttonColor = AppColors.green,
    this.borderColor = AppColors.green,
    this.padding = const EdgeInsets.all(0),
    this.onTap,
  }) : super(key: key);

  final Widget icon;
  final Color buttonColor;
  final Color borderColor;
  final EdgeInsets padding;
  final Function? onTap;

  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: InkWell(
          onTap: onTap as void Function()?,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: buttonColor,
              border: Border.all(color: borderColor, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(child: icon),
          ),
        ),
      );
}
