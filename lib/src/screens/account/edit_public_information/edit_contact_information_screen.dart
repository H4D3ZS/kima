import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_intl_phone_field.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';
import 'package:kima/src/utils/widgets/customs/custom_text_form_field.dart';

class EditContactInformationScreen extends StatefulWidget {
  static const route = 'profile/about/contact-information';

  const EditContactInformationScreen({Key? key}) : super(key: key);

  @override
  State<EditContactInformationScreen> createState() => _EditContactInformationScreenState();
}

class _EditContactInformationScreenState extends State<EditContactInformationScreen> {
  late TextEditingController emailController;
  late TextEditingController contactController;
  late String? completePhoneNumber;
  late String? email;
  late UserBloc userBloc;
  late UserProfile user;

  bool isPhoneNumberValid = true;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    user = userBloc.state.user!;

    completePhoneNumber = user.contactNumber;
    email = user.email;

    contactController = TextEditingController(text: phoneNumberOnly);
    emailController = TextEditingController(text: email)..addListener(() => setState(() {}));

    super.initState();
  }

  @override
  void dispose() {
    contactController.dispose();
    emailController.dispose();
    super.dispose();
  }

  String? get phoneNumberOnly =>
      completePhoneNumber != null ? PhoneNumber.fromCompleteNumber(completeNumber: completePhoneNumber!).number : null;

  bool get enableSave =>
      (isPhoneNumberValid || phoneNumberOnly?.isEmpty == true) && (email?.isNotEmpty == true && !email!.isEmailInvalid);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>.value(
      value: userBloc,
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          final status = state.status;

          if (status == Status.loading) {
            showLoader(context);
          }
          if (status == Status.failed) {
            closeLoader(context);
            CustomSnackBar.error(context, state.error!.message);
          }
          if (status == Status.success) {
            closeLoader(context);
            Navigator.pop(context);
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      'Contact Information',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                    InkWell(
                      onTap: enableSave
                          ? () => context.read<UserBloc>().add(
                                UpdateUserEvent(
                                  data: {
                                    'contactNumber': isPhoneNumberValid ? completePhoneNumber : null,
                                    'email': email,
                                  },
                                ),
                              )
                          : () {},
                      child: CustomText(
                        'Save',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontColor: enableSave ? AppColors.powderBlue : AppColors.lightGrey,
                      ),
                    ),
                  ],
                ),
                const VerticalSpace(40.0),
                const CustomText(
                  'Phone Number',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey10,
                ),
                const VerticalSpace(15.0),
                CustomIntlPhoneField(
                  completePhoneNumber: completePhoneNumber,
                  controller: contactController,
                  onContactChanged: (value, isValid) => setState(() {
                    completePhoneNumber = value;
                    isPhoneNumberValid = isValid;
                  }),
                ),
                const VerticalSpace(30.0),
                const CustomText(
                  'Email',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey10,
                ),
                const VerticalSpace(15.0),
                CustomTextFormField(
                  controller: emailController,
                  hint: 'Email address',
                  errorText: emailController.text.trim().isEmailInvalid ? 'Please enter a valid email address' : '',
                  onChanged: (value) => setState(() => email = value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
