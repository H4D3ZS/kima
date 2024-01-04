
import 'package:flutter/material.dart';
import 'package:kima/src/utils/helpers/color_helpers.dart';

/// Search TextField Default Widget --------------------------------------------
class SearchTextFieldDefault extends StatelessWidget {
  const SearchTextFieldDefault({
    super.key,
    required this.textController,
    this.width,
    this.height,
    this.margin = EdgeInsets.zero,
  });

  final TextEditingController textController;
  final double? width;
  final double? height;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: TextField(
        controller: textController,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        // onChanged: onChanged,
        decoration: InputDecoration(
          hintText: 'Search name or username',
          hintStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: HexColor('#F5F5F5'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          // border: const OutlineInputBorder(
          //   // borderSide: BorderSide(color: Colors.grey),
          //   borderRadius: BorderRadius.all(Radius.circular(20)),
          // ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide(
              width: 1.0,
              color: Colors.transparent,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            borderSide: BorderSide(
              width:  1.0,
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
