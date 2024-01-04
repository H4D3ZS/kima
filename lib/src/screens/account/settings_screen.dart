import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/blocs/common/app_bottom_nav_cubit.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/providers/authentication_provider.dart';
import 'package:kima/src/screens/account/edit_public_information/edit_about_info_screen.dart';
import 'package:kima/src/screens/account/edit_personal_information/edit_personal_information_screen.dart';
import 'package:kima/src/screens/account/privacy_policy_screen.dart';
import 'package:kima/src/screens/account/terms_and_conditions_screen.dart';
import 'package:kima/src/screens/account/upgrade_membership_screen.dart';
import 'package:kima/src/screens/authentication/login/login_screen.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_avatar.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/helpers/color_helpers.dart';
import 'package:kima/src/utils/widgets/common/header_wrapper.dart';
import 'package:kima/gen/assets.gen.dart';

class MenuInfo {
  String title;
  String? route;

  MenuInfo({
    required this.title,
    this.route
  });
}

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  static const route = '/accounts';

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  AuthenticationProvider authenticationProvider = AuthenticationProvider();

  List<MenuInfo> settingsMenu = [
    MenuInfo(title: 'Personal and Account Information', route: EditPersonalInformationScreen.route),
    MenuInfo(title: 'About Info', route: EditAboutInfoScreen.route),
    MenuInfo(title: 'Upgrade Membership', route: UpgradeMembershipScreen.route),
    MenuInfo(title: 'Terms and Conditions', route: TermsAndConditionsScreen.route),
    MenuInfo(title: 'Contact us', route: SettingsScreen.route),
    MenuInfo(title: 'Privacy Policy', route: PrivacyPolicyScreen.route),
  ];

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserBloc>(context).state.user;

    return HeaderWrapper(
      titleHeader: 'Account Settings',
      onBack: () => {
        Navigator.pop(context)
      },
      elevation: 1,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: AppColors.white5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ProfileAvatar(size: 50.0),
                  const SizedBox(width: 14.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user!.displayName,
                        style: GoogleFonts.poppins(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500
                        )
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text('View Profile',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            color: HexColor('#9F9F9F')
                          )
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            _buildSettingList(
              items: settingsMenu,
              context: context,
              isBusinessOrProUser: user.isBusinessOrProfessionalUser,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: InkWell(
                onTap: () async {
                  BlocProvider.of<AppBottomNavCubit>(context).emitBottomNav(BottomNavEnum.home);
                  BlocProvider.of<SwitchViewCubit>(context).selectedRoute('');

                  Navigator.pushNamed(context, LoginScreen.route);
                  await authenticationProvider.logout();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 17.0),
                  decoration: BoxDecoration(
                    color: HexColor('#F4F4F4'),
                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Assets.icons.iconLogout.svg(),
                      Text('Logout',
                        style: GoogleFonts.openSans(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildSettingList({ required List<MenuInfo> items, dynamic context, required isBusinessOrProUser }) {
  List<Widget> settings = [];
  for (var i = 0; i < items.length; i++) {
    settings.add(
    isBusinessOrProUser && (i == 2) ? const SizedBox() :
      InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            items[i].route!,
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 17.0, horizontal: 30.0),
          width: double.infinity,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: AppColors.white5),
            ),
          ),
          child: Text(items[i].title,
            style: GoogleFonts.poppins(
              fontSize: 16.0,
              color: Colors.black
            )
          )
        ),
      )
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: settings
  );
}