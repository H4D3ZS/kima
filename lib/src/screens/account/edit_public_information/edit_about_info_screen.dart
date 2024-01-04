import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/screens/account/edit_public_information/edit_basic_information_screen.dart';
import 'package:kima/src/screens/account/edit_public_information/edit_contact_information_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/header_wrapper.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/utils/widgets/common/vertical_space.dart';

class AboutInfo {
  String title;
  String route;
  List<Information> infoData;

  AboutInfo({required this.title, required this.route, required this.infoData});
}

class Information {
  late Widget iconData;
  String value;
  String label;

  Information({required this.iconData, required this.value, required this.label});
}

class EditAboutInfoScreen extends StatefulWidget {
  const EditAboutInfoScreen({super.key});

  static const route = '/accounts/about';

  @override
  State<EditAboutInfoScreen> createState() => _EditAboutInfoScreenState();
}

class _EditAboutInfoScreenState extends State<EditAboutInfoScreen> {
  List<AboutInfo> aboutInfo(UserProfile user) => [
        AboutInfo(
          title: 'Basic Information',
          route: EditBasicInformationScreen.route,
          infoData: <Information>[
            Information(
              iconData: Assets.icons.iconGender.svg(),
              value: user.genderValue?.label ?? 'Select one from the options',
              label: 'Gender',
            ),
            Information(
                iconData: Assets.icons.iconBirthday.svg(),
                value: user.birthDate != null
                    ? user.birthDate!.toDateFormat(DateTimeFormat.monthDayYear)
                    : 'Add your birthday',
                label: 'Birthday')
          ],
        ),
        AboutInfo(
          title: 'Contact Information',
          route: EditContactInformationScreen.route,
          infoData: <Information>[
            Information(
              iconData: Assets.icons.iconMobileNum.svg(),
              value: user.contactNumber ?? 'Add your Phone number',
              label: 'Mobile Number',
            ),
            Information(
              iconData: Assets.icons.iconEmail.svg(),
              value: user.email!,
              label: 'Email',
            )
          ],
        )
      ];

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserBloc>(context).state.user!;

    return HeaderWrapper(
      titleHeader: 'Edit About Info',
      onBack: () => {Navigator.pop(context)},
      elevation: 1,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView.builder(
          itemCount: aboutInfo(user).length,
          itemBuilder: (BuildContext context, int index) {
            List<Widget> infoWidgets = [];
            List<Information> infoData = aboutInfo(user)[index].infoData;
            for (var i = 0; i < infoData.length; i++) {
              infoWidgets.add(Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      infoData[i].iconData,
                      const SizedBox(width: 18),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            infoData[i].value,
                            style: GoogleFonts.poppins(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            infoData[i].label,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: AppColors.lightGrey10,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const VerticalSpace(15.0)
                ],
              ));
            }
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        aboutInfo(user)[index].title,
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(context, aboutInfo(user)[index].route).then(
                          (_) => setState(() {}),
                        ),
                        child: Text(
                          'Edit',
                          style: GoogleFonts.poppins(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                            color: AppColors.powderBlue,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const VerticalSpace(15.0),
                ...infoWidgets,
                const VerticalSpace(10.0)
              ],
            );
          },
        ),
      ),
    );
  }
}
