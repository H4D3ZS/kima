import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/app_back_button.dart';

class RegistrationAppBar extends StatelessWidget {
  const RegistrationAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppCircularBackButton(
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
