import 'package:flutter/material.dart';
import 'package:kima/src/screens/account/edit_public_information/edit_about_info_screen.dart';
import 'package:kima/src/screens/account/edit_personal_information/edit_personal_information_screen.dart';
import 'package:kima/src/screens/account/edit_public_information/edit_basic_information_screen.dart';
import 'package:kima/src/screens/account/edit_public_information/edit_contact_information_screen.dart';
import 'package:kima/src/screens/account/privacy_policy_screen.dart';
import 'package:kima/src/screens/account/edit_personal_information/review_personal_information_screen.dart';
import 'package:kima/src/screens/account/settings_screen.dart';
import 'package:kima/src/screens/account/terms_and_conditions_screen.dart';
import 'package:kima/src/screens/account/upgrade_membership_screen.dart';
import 'package:kima/src/screens/authentication/login/login_screen.dart';
import 'package:kima/src/screens/authentication/login/setup_name_screen.dart';
import 'package:kima/src/screens/authentication/registration/registration_screen.dart';
import 'package:kima/src/screens/authentication/splash/splash_screen.dart';
import 'package:kima/src/screens/classifieds/classifieds_screen.dart';
import 'package:kima/src/screens/classifieds/inner_classified_screen.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/dashboard_business_profile_screen.dart';
import 'package:kima/src/screens/dashboard/profile/edit_bio_screen.dart';
import 'package:kima/src/screens/dashboard/profile/edit_profile_screen.dart';
import 'package:kima/src/screens/dashboard/dashboard_screen.dart';
import 'package:kima/src/screens/dashboard/notifications/notifications_screen.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_regular_profile/dashboard_regular_profile_screen.dart';
import 'package:kima/src/screens/favorites/favorites_screen.dart';
import 'package:kima/src/screens/marketplace/classifieds_description_screen.dart';
import 'package:kima/src/screens/marketplace/marketplace_screen.dart';
import 'package:kima/src/screens/message/chat_screen.dart';
// import 'package:kima/src/screens/message/message_screen.dart';
import 'package:kima/src/screens/message/new_message_screen.dart';
import 'package:kima/src/screens/message/working%20chat/conversation_screen.dart';
import 'package:kima/src/screens/profile/about_screen.dart';
import 'package:kima/src/screens/profile/profile_edit_screen.dart';
import 'package:kima/src/screens/profile/profile_qr_code_screen.dart';
import 'package:kima/src/screens/profile/profile_screen.dart';
import 'package:kima/src/screens/qrcode/qr_code_screen.dart';
import 'package:kima/src/screens/qrcode/qr_code_scanner_screen.dart';
import 'package:kima/src/screens/report/report_additional_detail_screen.dart';
import 'package:kima/src/screens/report/report_screen.dart';
import 'package:kima/src/screens/report/report_success_screen.dart';
import 'package:kima/src/screens/root.dart';
import 'package:kima/src/screens/search/profile_visit/profile_visit_about_user_screen.dart';
import 'package:kima/src/screens/search/profile_visit/profile_visit_settings_screen.dart';
import 'package:kima/src/screens/search/search/search_screen.dart';

class AppRoute {
  /// Define your named routes using a Map of strings to widget builders
  static final Map<String, WidgetBuilder> _routes = {
    SplashScreen.route: (context) => const SplashScreen(),
    LoginScreen.route: (context) => const LoginScreen(),
    SetupNameScreen.route: (context) => const SetupNameScreen(),
    RegistrationScreen.route: (context) => const RegistrationScreen(),
    Root.route: (context) => const Root(),
    DashboardScreen.route: (context) => const DashboardScreen(),
    DashboardRegularProfileScreen.route: (context) =>
        const DashboardRegularProfileScreen(),
    DashboardBusinessProfileScreen.route: (context) =>
        const DashboardBusinessProfileScreen(),
    EditProfileScreen.route: (context) => const EditProfileScreen(),
    EditBioScreen.route: (context) => const EditBioScreen(),
    EditBasicInformationScreen.route: (context) =>
        const EditBasicInformationScreen(),
    EditContactInformationScreen.route: (context) =>
        const EditContactInformationScreen(),
    EditPersonalInformationScreen.route: (context) =>
        const EditPersonalInformationScreen(),
    ReviewPersonalInformationScreen.route: (context) =>
        const ReviewPersonalInformationScreen(),
    UpgradeMembershipScreen.route: (context) => const UpgradeMembershipScreen(),
    NotificationsScreen.route: (context) => const NotificationsScreen(),
    SearchScreen.route: (context) => const SearchScreen(),
    MarketPlaceScreen.route: (context) => const MarketPlaceScreen(),
    FavoritesScreen.route: (context) => const FavoritesScreen(),
    ConversationListScreen.route: (context) => const ConversationListScreen(),
    ChatScreen.route: (context) => const ChatScreen(),
    ProfileScreen.route: (context) => const ProfileScreen(),
    ProfileEditScreen.route: (context) => const ProfileEditScreen(),
    ProfileQRCodeScreen.route: (context) => const ProfileQRCodeScreen(),
    ProfileVisitSettingsScreen.route: (context) =>
        const ProfileVisitSettingsScreen(),
    ProfileVisitAboutUserScreen.route: (context) =>
        const ProfileVisitAboutUserScreen(),
    AboutScreen.route: (context) => const AboutScreen(),
    ReportScreen.route: (context) => const ReportScreen(),
    ClassifiedsScreen.route: (context) => const ClassifiedsScreen(),
    ClassifiedsDescriptionScreen.route: (context) =>
        const ClassifiedsDescriptionScreen(),
    ReportAdditionalDetailScreen.route: (context) =>
        const ReportAdditionalDetailScreen(),
    ReportSuccessScreen.route: (context) => const ReportSuccessScreen(),
    SettingsScreen.route: (context) => const SettingsScreen(),
    EditAboutInfoScreen.route: (context) => const EditAboutInfoScreen(),
    QRCodeScreen.route: (context) => const QRCodeScreen(),
    QRCodeScannerScreen.route: (context) => const QRCodeScannerScreen(),
    TermsAndConditionsScreen.route: (context) =>
        const TermsAndConditionsScreen(),
    PrivacyPolicyScreen.route: (context) => const PrivacyPolicyScreen(),
    InnerClassified.route: (context) => InnerClassified(),
    NewMessageScreen.route: (context) => const NewMessageScreen()
  };

  /// Define a function to handle route generation
  static Route<dynamic> generateRoute(RouteSettings settings) {
    /// Extract the route name from the settings argument
    final name = settings.name;

    /// Use the route name to find the corresponding builder function
    final builder = _routes[name];

    /// If a builder function was found, return the widget it builds
    if (builder != null) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
        settings: settings,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      );
    }

    /// If no builder function was found, return an error screen (SplashScreen in this case)
    return MaterialPageRoute(
      builder: (context) => const LoginScreen(),
      settings: settings,
    );
  }
}
