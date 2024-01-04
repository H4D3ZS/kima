import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ClassifiedsCardLocationListing extends StatelessWidget {
  const ClassifiedsCardLocationListing(
    this.location,
    this.listingDate, {
    Key? key,
  }) : super(key: key);

  final String location;
  final String listingDate;

  @override
  Widget build(BuildContext context) {
    final style = GoogleFonts.poppins(
      color: AppColors.lightGrey5,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(location, style: style),
        CustomText('Listed $listingDate', style: style),
      ],
    );
  }
}
