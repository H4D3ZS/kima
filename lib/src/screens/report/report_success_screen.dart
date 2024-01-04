import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/report/report_cubit.dart';
import 'package:kima/src/screens/marketplace/marketplace_screen.dart';
import 'package:kima/src/screens/search/search/search_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ReportSuccessScreen extends StatelessWidget {
  const ReportSuccessScreen({Key? key}) : super(key: key);

  static const route = '/report/success';

  @override
  Widget build(BuildContext context) {
    final isUserReport = ModalRoute.of(context)?.settings.arguments as ReportType == ReportType.user;

    return Scaffold(
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.green, AppColors.primaryColor],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 65.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // TODO: Replace with SVG. Currently svg file does not display any image when used
              Assets.icons.mainLogoPng.image(),
              const VerticalSpace(40.0),
              const CustomText(
                'We have received your report!',
                fontSize: 30.0,
                fontColor: Colors.white,
                alignment: TextAlign.center,
              ),
              const VerticalSpace(30.0),
              const CustomText(
                'Thank you for making our community safe',
                fontSize: 20.0,
                fontWeight: FontWeight.w400,
                fontColor: Colors.white,
                alignment: TextAlign.center,
              ),
              const VerticalSpace(60.0),
              ButtonWidget(
                onTap: () {
                  Navigator.pop(context);
                  BlocProvider.of<SwitchViewCubit>(context)
                      .selectedRoute(isUserReport ? SearchScreen.route : MarketPlaceScreen.route);
                  BlocProvider.of<ReportListCubit>(context).reset();
                },
                title: 'Go to ${isUserReport ? 'Community' : 'Marketplace'}',
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
                textColor: AppColors.green,
                buttonColor: Colors.white,
                buttonHeight: 60.0,
                borderRadius: 100.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
