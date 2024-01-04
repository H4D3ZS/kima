import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/utils/widgets/common/header_wrapper.dart';
import 'package:kima/src/utils/widgets/common/vertical_space.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  static const route = '/privacy-policy';

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  List<String> policyContent = [
    'When you apply for a Kima Membership, register as an Kima Member, register as a Basic Account Holder, or a premium account on our Site, we will collect personal information from you, such as your name, email address, country of origin, location, occupation, education, photos, social media accounts and other data you upload or enter into your profile.',
    'This personal data is entered by you during the application or registration process or shared by you through another social media service, in order to become a member of Kima App, or apply for membership or use another Kima  Service',
    'We do not store credit card information; this is handled by a third party who fully complies with the Payment Card Industry\'s Data Security Standard (PCI-DSS).',
    'We may also collect data about your navigation of the Site on an aggregate basis, such as your Internet Protocol Address (“IP Address”), which is identified and logged automatically in our server log files whenever you navigate the Site, your Internet Service Provider (“ISP”), your login frequency, the pages you visited within the Site, and the Internet browser or device you are using while browsing the Site.',
    'When you participate or redeem the Site’s member privileges, special offers, or complete forms for optional promotions, RSVP for events, or participate in contests, surveys, or beta testing, we may require you to submit personal information to the Site, our mobile apps or via email.',
    'You may also voluntarily provide personal information when you send us an enquiry or raise a support request via email. When you contact us, we keep a record of your communication and may use third-party service providers (e-mail marketing providers such as Emarsys, or CRM systems such as Salesforce), to help solve any issues you might be facing in the future.',
    'When you use Kima , you may share your location data with us to optimize your experience on the Site and Apps and inform other members of your upcoming travels. This data is voluntary and is shared with us and other members of the community and may be used to suggest other members to connect to you and you to connect to other members.',
    'Surveys are periodically conducted to collect information to help us improve the Site, our Apps and Services. All information collected through surveys will remain voluntary and confidential, even if we use a third party to help us conduct the survey.',
    'Any information you disclose in public areas of the Site and Apps may become public information. Please exercise caution when disclosing personal information in these areas. We are not responsible for any use by third parties of personal information disclosed by you in public areas of the Site.',
    'In order to facilitate the fulfillment of privileges for Members, you may authorize Kima  to provide private data relevant to privilege redemption to privilege partners in question. Your approval will be requested before such data is exchanged. Any such exchange only happens for the fulfillment of Member privileges.',

  ];

  @override
  Widget build(BuildContext context) {
    return HeaderWrapper(
      titleHeader: 'Privacy and Policy',
      elevation: 1,
      onBack: () => Navigator.pop(context),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: ListView.builder(
          itemCount: policyContent.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Text(policyContent[index],
                  style: GoogleFonts.poppins(
                    fontSize: 12.0,
                    color: Colors.black,
                  )),
                const VerticalSpace(15)
              ],
            );
          }
        ),
      )
    );
  }
}