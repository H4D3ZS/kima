import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/feed/feed_bloc.dart';
import 'package:kima/src/blocs/main/user/daily_status_bloc.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/dashboard_business_profile_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';
import 'package:kima/src/utils/widgets/customs/custom_text_form_field.dart';

class EditDailyStatus extends StatefulWidget {
  const EditDailyStatus({Key? key}) : super(key: key);

  static const route = '/business-profile/edit-daily-status';

  @override
  State<EditDailyStatus> createState() => _EditDailyStatusState();
}

class _EditDailyStatusState extends State<EditDailyStatus> {
  late TextEditingController _statusController;
  late FocusNode _focus;

  late SwitchViewCubit switchViewCubit;
  late DailyStatusBloc dailyStatusBloc;

  @override
  void initState() {
    super.initState();
    switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);
    dailyStatusBloc = BlocProvider.of<DailyStatusBloc>(context);

    _statusController = TextEditingController()..addListener(() => setState(() {}));
    _focus = FocusNode()..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _statusController.dispose();
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DailyStatusBloc>.value(
      value: dailyStatusBloc,
      child: BlocListener<DailyStatusBloc, DailyStatusState>(
        listener: (context, state) {
          final status = state.status;

          if (status == Status.loading) showLoader(context);
          if (status == Status.success) {
            closeLoader(context);
            switchViewCubit.selectedRoute(DashboardBusinessProfileScreen.route);
          }
          if (status == Status.failed) {
            closeLoader(context);
            CustomSnackBar.error(context, state.error!.message);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Update Daily Status',
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
              onTap: () => switchViewCubit.selectedRoute(DashboardBusinessProfileScreen.route),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  'Tell us what’s on your mind',
                  fontSize: 15.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey10,
                ),
                const VerticalSpace(25.0),
                CustomTextFormField(
                  controller: _statusController,
                  focusNode: _focus,
                  hint: '',
                  borderColor: _focus.hasFocus ? AppColors.green : AppColors.lightGrey40,
                  maxLength: 5,
                  inputFormatters: [LengthLimitingTextInputFormatter(200)],
                ),
                const VerticalSpace(5.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    '${_statusController.value.text.length}/200',
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.lightGrey,
                  ),
                ),
                const VerticalSpace(20.0),
                CustomButton.green(
                  label: 'Save and Update',
                  enable: _focus.hasFocus,
                  disabledBackgroundColor: AppColors.lightGrey,
                  onPressed: () {
                    context.read<DailyStatusBloc>().add(CreateDailyStatusEvent(_statusController.text));
                    context.read<FeedBloc>().add(GetProfileFeedEvent());
                  },
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  borderRadius: 4.0,
                  backgroundColor: AppColors.green,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
