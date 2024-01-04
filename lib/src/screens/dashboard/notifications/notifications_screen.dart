import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/screens/dashboard/dashboard_screen.dart';
import 'package:kima/src/screens/dashboard/notifications/widgets/notification_tile.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  static const route = '/notifications';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const CustomText(
            'Notifications',
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
            onTap: () => BlocProvider.of<SwitchViewCubit>(context).selectedRoute(DashboardScreen.route),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if unread notifs is not empty ...[]
              const Padding(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 15.0),
                child: CustomText('New', fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) => const NotificationTile(NotificationEnum.unread),
              ),
              // if read notifs is not empty ...[]
              const Padding(
                padding: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 15.0),
                child: CustomText('Earlier', fontSize: 18.0, fontWeight: FontWeight.w700),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) => const NotificationTile(NotificationEnum.read),
              ),
            ],
          ),
        ),
      );
}
