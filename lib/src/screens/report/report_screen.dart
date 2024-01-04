import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/classifieds/classified_details_cubit.dart';
import 'package:kima/src/blocs/main/report/report_bloc.dart';
import 'package:kima/src/blocs/main/report/report_cubit.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/models/report.dart';
import 'package:kima/src/screens/marketplace/classifieds_description_screen.dart';
import 'package:kima/src/screens/report/report_additional_detail_screen.dart';
import 'package:kima/src/screens/report/widgets/report_item.dart';
import 'package:kima/src/screens/search/profile_visit/profile_visit_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/mixins.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';

import '../../blocs/common/switch_view_cubit.dart';
import '../../utils/widgets/common/_common.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  static const route = '/report';

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> with DialogMixins {
  late SwitchViewCubit _switchViewCubit;
  late ReportListCubit _reportListCubit;
  late ReportBloc _reportBloc;
  late List<Report> reportList;

  @override
  void initState() {
    super.initState();
    _initBloc();
    _reportListCubit.reset();
    setState(() => reportList = _reportListCubit.state);
  }

  void _initBloc() {
    _switchViewCubit = BlocProvider.of<SwitchViewCubit>(context);
    _reportListCubit = BlocProvider.of<ReportListCubit>(context);
    _reportBloc = BlocProvider.of<ReportBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final type =  _reportBloc.state.type!;
    final isUserReport = type == ReportType.user;

    return BlocListener<ReportBloc, ReportState>(
      listener: (context, state) {
        if (state.status == Status.loading) showLoader(context);
        if (state.status == Status.success) {
          closeLoader(context);
          showReportModalBottomSheet(context, text: state.report!.reason!, type: type);
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
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 2.0,
          shadowColor: const Color(0xFFC3C3D1).withOpacity(0.25),
          toolbarHeight: 110.0,
          leadingWidth: 110.0,
          leading: CircularIconButton(
            icon: Assets.icons.iconArrowLeft.svg(),
            bgColor: AppColors.lightGrey20,
            margin: const EdgeInsets.symmetric(horizontal: 30.0),
            onTap: () => _switchViewCubit
                .selectedRoute(isUserReport ? ProfileVisitScreen.route : ClassifiedsDescriptionScreen.route),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              ..._reportListCubit.state.map(
                (report) => ReportItem(
                  report.reason!,
                  onTap: () => Listing.reportsWithAdditionalData.contains(report.reason)
                      ? {
                          _reportListCubit.select(report),
                          _switchViewCubit.selectedRoute(ReportAdditionalDetailScreen.route),
                        }
                      : {
                          _reportBloc.add(
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
                        },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
