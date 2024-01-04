import 'package:flutter/material.dart';

class CarouselDotIndicator extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;

  const CarouselDotIndicator({
    Key? key,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Container(
          width: 12.0,
          height: 12.0,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      );
}
