import 'package:flutter/material.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class UpgradeMembershipScreen extends StatelessWidget {
  static const route = 'profile/account-settings/upgrade-membership';

  const UpgradeMembershipScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Upgrade membership screen
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upgrade Membership',
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
          onTap: () => Navigator.pop(context),
        ),
      ),
      body: const Center(child: Text('UpgradeMembershipScreen')),
    );
  }
}
