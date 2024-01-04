import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/classifieds/classified_details_cubit.dart';
import 'package:kima/src/blocs/main/report/report_bloc.dart';
import 'package:kima/src/blocs/main/report/report_cubit.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/report/report_screen.dart';
import 'package:kima/src/screens/report/widgets/report_item.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/mixins.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';

class ReportAdditionalDetailScreen extends StatelessWidget with DialogMixins {
  const ReportAdditionalDetailScreen({Key? key}) : super(key: key);

  static const route = '/report/additional-detail';

  @override
  Widget build(BuildContext context) {
    final reportCubit = BlocProvider.of<ReportListCubit>(context);
    final switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);
    final reportBloc = BlocProvider.of<ReportBloc>(context);

    final type =  reportBloc.state.type!;
    final isUserReport = type == ReportType.user;

    return BlocListener<ReportBloc, ReportState>(
      listener: (context, state) {
        if (state.status == Status.loading) showLoader(context);
        if (state.status == Status.success) {
          closeLoader(context);
          final report = state.report!;
          showReportModalBottomSheet(context, text: '${report.reason} - ${report.details}', type: type);
        }
        if (state.status == Status.failed) {
          closeLoader(context);
          CustomSnackBar.error(context, state.error!.message);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Report ${isUserReport ? 'User' : 'Post'}',
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
              onTap: () {
                switchViewCubit.selectedRoute(ReportScreen.route);
                reportCubit.reset();
              }),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              ...reportCubit.state.map(
                (report) => ReportItem(
                  report.details!,
                  onTap: () => reportBloc.add(
                    isUserReport
                        ? ReportUserEvent(
                            report.copyWith(
                              id: BlocProvider.of<UserBloc>(context).state.userVisit?.id,
                            ),
                          )
                        : ReportClassifiedsEvent(
                            report.copyWith(
                              id: BlocProvider.of<ClassifiedDetailsCubit>(context).state?.id,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
