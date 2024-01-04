import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ProfileVisitAboutUserScreen extends StatelessWidget {
  static const route = '/profile-visit/about';

  const ProfileVisitAboutUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserBloc>(context).state.userVisit;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About ${user?.firstName}',
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 2.0,
        shadowColor: const Color(0xFFC3C3D1).withOpacity(0.25),
        toolbarHeight: 95.0,
        leadingWidth: 110.0,
        leading: CircularIconButton(
          icon: Assets.icons.iconArrowLeft.svg(),
          bgColor: AppColors.lightGrey20,
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              'Basic Information',
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            const VerticalSpace(30.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.icons.iconGender.svg(),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.gender?.toTitleCase() ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Gender',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.lightGrey10,
                      ),
                    ),
                    const VerticalSpace(5.0),
                  ],
                )
              ],
            ),
            const VerticalSpace(15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.icons.iconBirthday.svg(),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.birthDate != null ? user!.birthDate!.toDateFormat(DateTimeFormat.monthDayYear) : '',
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Birthday',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.lightGrey10,
                      ),
                    ),
                    const VerticalSpace(5.0),
                  ],
                )
              ],
            ),
            const VerticalSpace(30.0),
            const CustomText(
              'Contact Information',
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            const VerticalSpace(30.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.icons.iconMobileNum.svg(),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.contactNumber ?? '',
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Mobile Number',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.lightGrey10,
                      ),
                    ),
                    const VerticalSpace(5.0),
                  ],
                )
              ],
            ),
            const VerticalSpace(15.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Assets.icons.iconEmail.svg(),
                const SizedBox(width: 18),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user!.email!,
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Email',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: AppColors.lightGrey10,
                      ),
                    ),
                    const VerticalSpace(5.0),
                  ],
                )
              ],
            ),
            const VerticalSpace(30.0),
            const CustomText(
              'About',
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            const VerticalSpace(30.0),
            CustomText(
              user.about ?? '',
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
