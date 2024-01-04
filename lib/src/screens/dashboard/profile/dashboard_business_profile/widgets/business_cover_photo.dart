import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/dashboard/profile/widgets/profile_avatar.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/helpers/image_picker_helper.dart';

class BusinessCoverPhoto extends StatelessWidget {
  const BusinessCoverPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Column(
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return Container(
                      width: double.infinity,
                      height: 200.0,
                      color: AppColors.lightGrey20,
                    );
                  }
                  final user = state.user!;
                  return FutureBuilder(
                    future: CacheManagerHelper.getImageFromCache('${user.id}_cover'),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Image.file(
                          File(snapshot.data!),
                          height: 200.0,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        );
                      }
                      return Container(
                        width: double.infinity,
                        height: 200.0,
                        color: AppColors.lightGrey20,
                      );
                    });
                },
              ),
              Container(
                height: 60.0,
                color: Colors.white,
              ),
            ],
          ),
          const Positioned(
            top: 140.0,
            left: 30.0,
            child: ProfileAvatar(),
          ),
        ],
      );
}
