import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/user/daily_status_bloc.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_business_profile/edit_daily_status_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class DailyStatus extends StatelessWidget {
  final bool isEditable;

  const DailyStatus({
    this.isEditable = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<DailyStatusBloc, DailyStatusState>(
        builder: (context, state) {
          return Container(
            color: Colors.white,
            margin: EdgeInsets.only(top: isEditable ? 15.0 : 10.0),
            padding: const EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText('Daily Status', fontWeight: FontWeight.w400),
                    if (isEditable)
                      state.status == Status.loading
                          ? const CupertinoActivityIndicator()
                          : InkWell(
                              onTap: () =>
                                  BlocProvider.of<SwitchViewCubit>(context).selectedRoute(EditDailyStatus.route),
                              child: const CustomText(
                                'Edit',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w400,
                                fontColor: AppColors.powderBlue,
                              ),
                            ),
                  ],
                ),
                const VerticalSpace(14.0),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(minHeight: 40.0),
                  padding: const EdgeInsets.fromLTRB(16.0, 10.0, 0.0, 10.0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    image: DecorationImage(
                      image: AssetImage('assets/temporary/daily-status-bg.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: CustomText(
                    // TODO: For profile visit, get daily status of user you are viewing
                    !isEditable ? '' : state.dailyStatus?.statusContent ?? '',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                    fontColor: AppColors.lightGrey10,
                  ),
                )
              ],
            ),
          );
        },
      );
}
