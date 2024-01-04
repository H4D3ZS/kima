import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/constants/terms_and_conditions_constants.dart';
import 'package:kima/src/utils/widgets/common/header_wrapper.dart';
import 'package:kima/src/utils/widgets/common/vertical_space.dart';

class TermsAndConditionsScreen extends StatefulWidget {
  const TermsAndConditionsScreen({super.key});

  static const route = '/terms-conditions';

  @override
  State<TermsAndConditionsScreen> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditionsScreen> {
  @override
  Widget build(BuildContext context) {
    return HeaderWrapper(
      titleHeader: 'Terms and Conditions',
      onBack: () => Navigator.pop(context),
      elevation: 1,
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: ListView(
          children: [
            Text(
              TermsAndConditionsConstants.NoteConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Definitions',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.DefinitionsConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Changes to the terms',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.ChangesTermsConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Translation',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.TranslationConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Using the service',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.UsingServiceConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Content',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.ContentConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Booking Transacting',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.BookingTransactingConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Representation and Warranties',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.RepresentationWarrantiesConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Additional Policies and Terms',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.AdditionalPoliciesTermsConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Suggestions and Improvements',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.SuggestionImprovementsConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Third Party Content and Services',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.ThirdPartyContentServiceConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Indemnity',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.IndemnityConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Disclaimers and Limitations of Liability',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.DisclaimerLimitationLiabilityConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Arbitration, Disputes and Choice of Law',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.ArbitrationDisputesChoicesLawConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Termination',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.TerminationConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Additional terms for Business Accounts',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.AdditionalTermsBusinessAccountsConstants,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
            const VerticalSpace(15),
            Text(
              'Requirements, Representations and Warranties',
              style: GoogleFonts.poppins(
                fontSize: 16.0,
                color: Colors.black,
                fontWeight: FontWeight.w500
              ),
            ),
            const VerticalSpace(15),
            Text(
              TermsAndConditionsConstants.RequirementsRepresentationWarrantiesConstant,
              style: GoogleFonts.poppins(
                fontSize: 12.0,
                color: Colors.black
              ),
            ),
          ],
        )
      )
    );
  }
}