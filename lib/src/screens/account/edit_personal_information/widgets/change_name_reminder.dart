import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/utils/colors.dart';

class ChangeNameReminder extends StatelessWidget {
  const ChangeNameReminder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: AppColors.lightGrey30,
        ),
        child: RichText(
          text: TextSpan(
            text: 'Please note: ',
            style: GoogleFonts.poppins(
              fontSize: 14.0,
              color: AppColors.lightGrey10,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text:
                    'If you change your name, you can\’t change it again for 60 days. Don’t add any unusual capitalization, punctuation, characters or random words.',
                style: GoogleFonts.poppins(
                  fontSize: 14.0,
                  color: AppColors.lightGrey10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      );
}
