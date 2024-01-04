import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/account/edit_personal_information/widgets/change_name_reminder.dart';
import 'package:kima/src/screens/root.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/screen_arguments.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ReviewPersonalInformationScreen extends StatelessWidget {
  static const route = 'profile/account-settings/review-edit-information';

  const ReviewPersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenArguments args = ModalRoute.of(context)?.settings.arguments as ScreenArguments;
    final name = args.data.values.where((name) => name.isNotEmpty).join(' ');

    return BlocProvider<UserBloc>.value(
      value: BlocProvider.of<UserBloc>(context),
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status == Status.loading) {
            showLoader(context);
          }
          if (state.status == Status.success) {
            closeLoader(context);
            Navigator.pushNamedAndRemoveUntil(context, Root.route, (_) => false);
          }
          if (state.status == Status.failed) {
            closeLoader(context);
            CustomSnackBar.error(context, state.error!.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Edit',
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
              onTap: () => Navigator.pop(context),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  'Preview Your New Name',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
                const VerticalSpace(40.0),
                const CustomText(
                  'This is what will appear on your profile:',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey10,
                ),
                const VerticalSpace(15.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: AppColors.lightGrey30),
                  ),
                  child: CustomText(
                    name,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const VerticalSpace(30.0),
                const ChangeNameReminder(),
                const VerticalSpace(40.0),
                CustomButton.green(
                  backgroundColor: AppColors.green,
                  borderColor: Colors.transparent,
                  label: 'Save Changes',
                  onPressed: () => context.read<UserBloc>().add(UpdateUserEvent(data: args.data)),
                ),
                const VerticalSpace(15.0),
                CustomButton.white(
                  backgroundColor: AppColors.lightGrey30,
                  borderColor: AppColors.lightGrey30,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  labelColor: AppColors.black10,
                  label: 'Cancel',
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
