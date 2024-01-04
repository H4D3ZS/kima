
import 'package:flutter/material.dart';

import '../../colors.dart';

/// Default Button -------------------------------------------------------------
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.onTap,
    required this.title,
    this.textColor = Colors.white,
    this.buttonColor = AppColors.primaryColor,
    this.borderColor = Colors.transparent,
    this.borderRadius = 20,
    this.borderWidth = 1,
    this.fontWeight = FontWeight.normal,
    this.fontSize = 15,
    this.buttonWidth,
    this.buttonHeight,
    this.padding = const EdgeInsets.all(0),
    this.margin = const EdgeInsets.all(0),
    this.visible = true,
  }) : super(key: key);

  final Function onTap;
  final String title;
  final Color textColor;
  final Color buttonColor;
  final Color borderColor;
  final double borderRadius;
  final double borderWidth;
  final FontWeight fontWeight;
  final double fontSize;
  final double? buttonWidth;
  final double? buttonHeight;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Padding(
        padding: margin,
        child: InkWell(
          onTap: () {
            onTap();
          },
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          focusColor: Colors.transparent,
          child: Container(
            padding: padding,
            width: buttonWidth,
            height: buttonHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: buttonColor,
              border: Border.all(color: borderColor, width: borderWidth),
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}