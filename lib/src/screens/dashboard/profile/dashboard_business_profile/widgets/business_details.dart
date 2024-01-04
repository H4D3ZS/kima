import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_details_tile.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/constants.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_button.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class BusinessDetails extends StatelessWidget {
  const BusinessDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserBloc>(context).state.user;

    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(
                  'Details',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
                const VerticalSpace(20.0),
                // TODO: Uncomment once the following data are available for the user
                // ProfileDetailsTile('Queens, New York', icon: IconMap.dashboardProfileDetails[0].svg()),
                // const VerticalSpace(16.0),
                ProfileDetailsTile(
                  'Joined ${user?.createdAt?.toDateFormat(DateTimeFormat.monthYear)}',
                  icon: IconMap.dashboardProfileDetails[1].svg(),
                ),
                const VerticalSpace(16.0),
                // ProfileDetailsTile('NyingmaCenter', icon: IconMap.dashboardProfileDetails[2].svg()),
                // const VerticalSpace(16.0),
                // ProfileDetailsTile('Nyingma', icon: IconMap.dashboardProfileDetails[3].svg()),
                // const VerticalSpace(16.0),
                ProfileDetailsTile(
                  'See your About info',
                  icon: IconMap.dashboardProfileDetails[4].svg(
                    colorFilter: AppColors.lightGrey8.toColorFilter,
                    width: 18.0,
                    height: 18.0,
                  ),
                ),
              ],
            ),
          ),
          CustomButton.green(
            label: 'Edit Public Details',
            labelColor: AppColors.green,
            fontWeight: FontWeight.w700,
            fontSize: 16.0,
            onPressed: () {},
            borderRadius: 0.0,
            borderColor: Colors.transparent,
            backgroundColor: AppColors.green.withOpacity(0.24),
          ),
          const VerticalSpace(20.0),
        ],
      ),
    );
  }
}
