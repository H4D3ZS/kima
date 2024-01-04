import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class RegistrationAccountTypeRadio extends StatelessWidget {
  final String label;
  final bool selected;
  final Function() onPressed;

  const RegistrationAccountTypeRadio({
    super.key,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Container(
              height: 20.0,
              width: 20.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF9F9F9F),
                ),
                color: selected ? const Color(0xFF000000) : const Color(0xFFFFFFFF),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 20.0),
            CustomText(label),
          ],
        ),
      ),
    );
  }
}
