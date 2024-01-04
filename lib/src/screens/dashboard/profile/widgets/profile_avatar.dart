import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/helpers/image_picker_helper.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class ProfileAvatar extends StatelessWidget {
  final double? size;
  final UserProfile? userProfile;

  const ProfileAvatar({
    Key? key,
    this.size = 120.0,
    this.userProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return Container(
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white5,
                ),
            );
          }
          final user = userProfile ?? state.user!;
          return FutureBuilder(
              future: CacheManagerHelper.getImageFromCache('${user.id!}_avatar'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ClipOval(
                    child: Image.file(
                      File(snapshot.data!),
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                    ),
                  );
                }
                return CircleAvatar(
                  radius: size! / 2,
                  backgroundColor: AppColors.green,
                  child: CustomText(
                    user.firstName![0],
                    fontSize: size == 120.0 ? 50.0 : 25.0,
                    fontWeight: FontWeight.w700,
                    fontColor: Colors.white,
                  ),
                );
              });
        }
    );
  }
}
