import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/mixins.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';

class DashboardBusinessTitle extends StatelessWidget with DialogMixins {
  const DashboardBusinessTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final user = BlocProvider.of<UserBloc>(context).state.user!;

    return Container(
      padding: const EdgeInsets.all(30.0),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.lightGrey20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  user.displayName,
                  fontWeight: FontWeight.w500,
                ),
                const CustomText(
                  // TODO: Nature of business
                  '',
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  fontColor: AppColors.lightGrey10,
                ),
              ],
            ),
          ),
          const HorizontalSpace(20.0),
          CircularIconButton(
            icon: Assets.icons.share.svg(),
            bgColor: Colors.transparent,
            borderColor: AppColors.powderBlue,
            borderWidth: 2.0,
            height: 40.0,
            width: 40.0,
            onTap: () => showShareModalBottomSheet(context, user),
          ),
        ],
      ),
    );
  }
}
