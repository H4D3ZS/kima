import 'package:flutter/material.dart';

class CircularAvatarButton extends StatelessWidget {
  const CircularAvatarButton({
    Key? key,
    required this.image,
    required this.onTap,
    this.size = 50.0,
  }) : super(key: key);

  final String? image;
  final double? size;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: ClipOval(
          child: image?.isNotEmpty == true
              ? Image.asset(
                  image!,
                  width: size,
                  height: size,
                  fit: BoxFit.cover,
                )
              : Icon(Icons.person, size: size),
        ),
      );
}
