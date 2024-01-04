import 'package:flutter/material.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_avatar.dart';

class CircularProfileAvatar extends StatelessWidget {
  const CircularProfileAvatar({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: const ProfileAvatar(size: 50.0),
      );
}
