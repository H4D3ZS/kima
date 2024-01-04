import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class CustomRadioListTile<T> extends StatelessWidget {
  final String label;
  final T groupValue;
  final T value;
  final Function(T) onSelect;

  const CustomRadioListTile({
    required this.label,
    required this.groupValue,
    required this.value,
    required this.onSelect,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: AppColors.white5),
          ),
        ),
        child: RadioListTile<T>(
          selected: value == groupValue,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.trailing,
          title: CustomText(
            label,
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
          ),
          value: value,
          groupValue: groupValue,
          onChanged: (value) => onSelect(value as T),
        ),
      );
}
