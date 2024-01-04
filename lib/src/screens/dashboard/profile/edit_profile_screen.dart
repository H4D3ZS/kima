import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/account/edit_public_information/edit_about_info_screen.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_regular_profile/dashboard_regular_profile_screen.dart';
import 'package:kima/src/screens/dashboard/profile/edit_bio_screen.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/edit_profile/edit_bio.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/edit_profile/edit_cover_photo.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/edit_profile/edit_profile_image.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  static const route = '/profile/edit-profile';

  @override
  Widget build(BuildContext context) {
    final switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);
    final user = BlocProvider.of<UserBloc>(context).state.user;

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state.photoStatus == PhotoStatus.failed) {
          CustomSnackBar.error(context, state.error!.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
            style: TextStyle(
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
            onTap: () => switchViewCubit.selectedRoute(user!.isBusinessOrProfessionalUser
                ? DashboardRegularProfileScreen.route
                : DashboardRegularProfileScreen.route),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 30.0),
            child: Column(
              children: [
                const EditProfileImage(),
                const VerticalSpace(10.0),
                const EditCoverPhoto(),
                const VerticalSpace(25.0),
                EditData(
                  title: 'Bio',
                  data: user?.about?.isNotEmpty == true ? user!.about! : 'Please tell us something about yourself.',
                  onTapEdit: () => switchViewCubit.selectedRoute(EditBioScreen.route),
                ),
                if (user!.isBusinessUser) ...[
                  const VerticalSpace(25.0),
                  EditData(
                    title: 'Nature of Business',
                    // TODO: Field not yet existing for user
                    data: '',
                    onTapEdit: () {},
                  ),
                ],
                if (user.isProfessionalUser) ...[
                  const VerticalSpace(25.0),
                  EditData(
                    title: 'Job Title',
                    data: user.jobTitle ?? '',
                    onTapEdit: () {},
                  ),
                ],
                const VerticalSpace(30.0),
                CustomButton.green(
                  label: 'Edit About Info',
                  onPressed: () => Navigator.pushNamed(context, EditAboutInfoScreen.route),
                  height: 40.0,
                  labelColor: AppColors.primaryColor,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.24),
                  borderColor: Colors.transparent,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
