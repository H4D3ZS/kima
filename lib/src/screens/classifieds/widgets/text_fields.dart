import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kima/src/utils/helpers/color_helpers.dart';

class TextFieldProps {
  String? textHints;
  void Function(String)? onChanged;
  TextInputType? keyboardType;
  int? maxLines;

  TextFieldProps({
    this.textHints,
    this.onChanged,
    this.keyboardType = null,
    this.maxLines = null
  });
}

class SingleTextField extends StatelessWidget {

  TextEditingController? controller = TextEditingController();
  TextFieldProps field = TextFieldProps();
  SingleTextField({super.key,  required this.field, this.controller });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          width: 1,
          color: HexColor('#F4F4F4'),
        ),
      ),  
      child: TextField(
        controller: controller,
        keyboardType: field.keyboardType,
        maxLines: field.maxLines,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
        ),
        onChanged: field.onChanged,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          hintText: field.textHints,
          hintStyle: const TextStyle(fontSize: 16.0),
          filled: true,
          fillColor: HexColor('#FFFFFF'),
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            borderSide: BorderSide(
              color: Colors.black,
              width: 2.0,
            ),

          )
        ),
      ),
    );
  }
}