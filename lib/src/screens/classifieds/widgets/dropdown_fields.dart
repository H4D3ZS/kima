import 'package:flutter/material.dart';
import 'package:kima/src/utils/helpers/color_helpers.dart';

class DropdownFieldProps {
  List<dynamic>? items = [];
  String? textHints;
  String? selected;
  void Function(dynamic)? onChanged;

  DropdownFieldProps({
    this.textHints,
    this.items,
    this.onChanged,
    this.selected
  });
}

class SingleDropdownField extends StatelessWidget {
  
  DropdownFieldProps field = DropdownFieldProps();

  SingleDropdownField({ super.key, required this.field });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: HexColor('#F4F4F4')),
        borderRadius: const BorderRadius.all(Radius.circular(5.0))
      ),
      width: MediaQuery.of(context).size.width,
      child: DropdownButton(
        underline: const SizedBox(),
        isExpanded: true,
        hint: Text(field.selected != '' ? field.selected! : field.textHints!),
        items: field.items?.map((dynamic value) {
          return DropdownMenuItem<dynamic>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: field.onChanged
      )
    );
  }
}