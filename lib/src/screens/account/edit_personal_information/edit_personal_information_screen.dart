import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/screens/account/edit_personal_information/review_personal_information_screen.dart';
import 'package:kima/src/screens/account/edit_personal_information/widgets/change_name_reminder.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/screen_arguments.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';
import 'package:kima/src/utils/widgets/customs/labeled_text_field.dart';

class EditPersonalInformationScreen extends StatefulWidget {
  static const route = 'profile/account-settings/edit-information';

  const EditPersonalInformationScreen({Key? key}) : super(key: key);

  @override
  State<EditPersonalInformationScreen> createState() => _EditPersonalInformationScreenState();
}

class _EditPersonalInformationScreenState extends State<EditPersonalInformationScreen> {
  late UserBloc userBloc;
  late UserProfile user;

  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    user = userBloc.state.user!;

    _firstNameController = TextEditingController(text: user.firstName)..addListener(() => setState(() => {}));
    _middleNameController = TextEditingController(text: user.middleName)..addListener(() => setState(() => {}));
    _lastNameController = TextEditingController(text: user.lastName)..addListener(() => setState(() => {}));
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _middleNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!_allowChanges) ...[
              Text(
                'You can\'t change your name because you\'ve changed it in the last 60 days.',
                style: GoogleFonts.poppins(
                  color: Colors.red[300],
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  height: 1.3,
                ),
              ),
              const VerticalSpace(10.0),
            ],
            const CustomText(
              'Name',
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
            const VerticalSpace(40.0),
            LabeledTextField(
              label: 'First name',
              controller: _firstNameController,
            ),
            const VerticalSpace(30.0),
            LabeledTextField(
              label: 'Middle name',
              controller: _middleNameController,
            ),
            const VerticalSpace(30.0),
            LabeledTextField(
              label: 'Last name',
              controller: _lastNameController,
            ),
            const VerticalSpace(30.0),
            const ChangeNameReminder(),
            const VerticalSpace(30.0),
            CustomButton.green(
              backgroundColor: AppColors.green.withOpacity(0.24),
              borderColor: Colors.transparent,
              labelColor: AppColors.green,
              label: 'Review Changes',
              enable: _enableReviewChanges,
              onPressed: () => Navigator.pushNamed(
                context,
                ReviewPersonalInformationScreen.route,
                arguments: ScreenArguments({
                  'firstName': _firstNameController.text,
                  'middleName': _middleNameController.text,
                  'lastName': _lastNameController.text,
                }),
              ),
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
    );
  }

  bool get _allowChanges {
    if (user.nameUpdatedAt != null) {
      final nameUpdateDate = DateTime.parse(user.nameUpdatedAt!);
      final daysSinceLastUpdate = DateTime.now().difference(nameUpdateDate).inDays;
      return daysSinceLastUpdate > 60;
    }
    return true;
  }

  bool get _enableReviewChanges {
    final hasFirstName = _firstNameController.text.isNotEmpty;
    final hasNewFirstName = user.firstName != _firstNameController.text;

    final hasLastName = _lastNameController.text.isNotEmpty;
    final hasNewLastName = user.lastName != _lastNameController.text;

    final hasNewMiddleName = _middleNameController.text.isNotEmpty;

    if ((hasNewFirstName || hasNewLastName || hasNewMiddleName) && (hasFirstName && hasLastName) && _allowChanges) {
      return true;
    }
    return false;
  }
}
