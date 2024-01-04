import 'package:flutter/material.dart';

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace(this.width, {Key? key}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) => SizedBox(width: width);
}
