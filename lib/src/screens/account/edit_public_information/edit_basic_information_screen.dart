import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_date_picker.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';
import 'package:kima/src/utils/widgets/customs/custom_radio_list_tile.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class EditBasicInformationScreen extends StatefulWidget {
  static const route = 'profile/about/basic-information';

  const EditBasicInformationScreen({Key? key}) : super(key: key);

  @override
  State<EditBasicInformationScreen> createState() => _EditBasicInformationScreenState();
}

class _EditBasicInformationScreenState extends State<EditBasicInformationScreen> {
  late Gender? gender;
  late DateTime? birthDate;
  late UserBloc userBloc;
  late UserProfile user;

  @override
  void initState() {
    userBloc = BlocProvider.of<UserBloc>(context);
    user = userBloc.state.user!;
    gender = user.genderValue;
    birthDate = user.birthDate != null ? DateTime.parse(user.birthDate!).toLocal() : null;
    super.initState();
  }

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
                      'Basic Information',
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                    InkWell(
                      onTap: () => context.read<UserBloc>().add(
                            UpdateUserEvent(
                              data: {
                                'gender': gender?.name,
                                'birthDate': birthDate?.toUtc().toIso8601String(),
                              },
                            ),
                          ),
                      child: const CustomText(
                        'Save',
                        fontSize: 14.0,
                        fontWeight: FontWeight.w500,
                        fontColor: AppColors.powderBlue,
                      ),
                    ),
                  ],
                ),
                const VerticalSpace(40.0),
                const CustomText(
                  'Gender',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey10,
                ),
                const VerticalSpace(15.0),
                CustomRadioListTile<Gender?>(
                  label: Gender.female.label,
                  groupValue: gender,
                  value: Gender.female,
                  onSelect: (value) => setState(() => gender = value),
                ),
                CustomRadioListTile<Gender?>(
                  label: Gender.male.label,
                  groupValue: gender,
                  value: Gender.male,
                  onSelect: (value) => setState(() => gender = value),
                ),
                const VerticalSpace(30.0),
                const CustomText(
                  'Birthdate',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey10,
                ),
                const VerticalSpace(15.0),
                CustomDatePicker(
                  initialDate: birthDate,
                  onSelectDate: (value) => setState(() => birthDate = value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
