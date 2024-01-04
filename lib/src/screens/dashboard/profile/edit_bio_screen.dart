import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/dashboard/profile/edit_profile_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';
import 'package:kima/src/utils/widgets/customs/custom_text_form_field.dart';

class EditBioScreen extends StatefulWidget {
  const EditBioScreen({Key? key}) : super(key: key);

  static const route = '/profile/edit-bio';

  @override
  State<EditBioScreen> createState() => _EditBioScreenState();
}

class _EditBioScreenState extends State<EditBioScreen> {
  late TextEditingController _bioController;
  late FocusNode _focus;

  late SwitchViewCubit switchViewCubit;
  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();
    switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);
    userBloc = BlocProvider.of<UserBloc>(context);

    _bioController = TextEditingController(text: userBloc.state.user?.about)..addListener(() => setState(() {}));
    _focus = FocusNode()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _bioController.dispose();
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>.value(
      value: userBloc,
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            switchViewCubit.selectedRoute(EditProfileScreen.route);
          }
          if (state.status == Status.failed) {
            CustomSnackBar.error(context, state.error!.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Edit Bio',
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
              onTap: () => switchViewCubit.selectedRoute(EditProfileScreen.route),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  'Tell us something about you.',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey10,
                ),
                const VerticalSpace(25.0),
                CustomTextFormField(
                  controller: _bioController,
                  focusNode: _focus,
                  hint: '',
                  borderColor: _focus.hasFocus ? AppColors.green : AppColors.lightGrey40,
                  maxLength: 4,
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                ),
                const VerticalSpace(5.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    '${_bioController.value.text.length}/100',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.lightGrey,
                  ),
                ),
                const VerticalSpace(20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton.white(
                      label: 'Cancel',
                      onPressed: () => BlocProvider.of<SwitchViewCubit>(context).selectedRoute(EditProfileScreen.route),
                      width: 134.0,
                      height: 40.0,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      borderRadius: 4.0,
                      borderColor: Colors.transparent,
                      backgroundColor: AppColors.lightGrey40,
                    ),
                    const HorizontalSpace(15.0),
                    BlocBuilder<UserBloc, UserState>(
                      builder: (context, state) => CustomButton.green(
                        icon: state.status == Status.loading
                            ? const CupertinoActivityIndicator(color: Colors.white)
                            : const SizedBox(),
                        label: 'Update',
                        enable: _focus.hasFocus,
                        disabledBackgroundColor: AppColors.lightGrey,
                        onPressed: () {
                          context.read<UserBloc>().add(
                                UpdateUserEvent(
                                  data: {
                                    "userDescription": _bioController.text,
                                  },
                                ),
                              );
                        },
                        width: 134.0,
                        height: 40.0,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                        borderRadius: 4.0,
                        backgroundColor: AppColors.green,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
