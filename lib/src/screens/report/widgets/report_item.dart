import 'package:flutter/material.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ReportItem extends StatelessWidget {
  const ReportItem(
    this.text, {
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 11.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  text,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
                size: 20,
              ),
            ],
          ),
        ),
      );
}
