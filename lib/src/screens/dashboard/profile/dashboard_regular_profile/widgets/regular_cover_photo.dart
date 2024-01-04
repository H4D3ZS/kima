import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/common/switch_view_cubit.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/dashboard/dashboard_screen.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_avatar.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/helpers/image_picker_helper.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class RegularCoverPhoto extends StatelessWidget {
  const RegularCoverPhoto({
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return Container(
                    width: double.infinity,
                    height: 250.0,
                    color: AppColors.lightGrey20,
                  );
                }
                final user = state.user;
                return FutureBuilder(
                    future: CacheManagerHelper.getImageFromCache('${user?.id}_cover'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.file(
                          File(snapshot.data!),
                          height: 250.0,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        );
                      }
                      return Container(
                        width: double.infinity,
                        height: 250.0,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.center,
                            colors: [
                              Colors.black.withOpacity(0.48),
                              Colors.black.withOpacity(0.05),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
            Container(
              height: 50.0,
              color: Colors.white,
            ),
          ],
        ),
        Positioned(
          top: 60.0,
          left: 30.0,
          child: CircularIconButton(
            onTap: () {
              BlocProvider.of<SwitchViewCubit>(context).selectedRoute(DashboardScreen.route);
            },
            icon: Assets.icons.iconArrowLeft.svg(),
            bgColor: Colors.white,
            width: 50.0,
            height: 50.0,
          ),
        ),
        Positioned(
          top: 170.0,
          left: 30.0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: const ProfileAvatar(),
          ),
        )
      ],
    );
  }
}
