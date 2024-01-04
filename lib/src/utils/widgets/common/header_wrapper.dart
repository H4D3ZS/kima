import 'package:flutter/material.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';

class HeaderWrapper extends StatelessWidget {
  Key? keyName;
  String titleHeader;
  void Function() onBack;
  List<Widget>? actions;
  Widget body;
  Widget? drawer;
  Widget? endDrawer;
  dynamic? bottom;
  double? elevation;
  double? toolbarHeight;

  HeaderWrapper({
    super.key,
    this.actions,
    this.drawer,
    this.endDrawer,
    this.keyName,
    this.bottom,
    this.elevation,
    this.toolbarHeight = 110.0,
    required this.body,
    required this.titleHeader,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: keyName,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          titleHeader,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: elevation,
        toolbarHeight: toolbarHeight,
        leadingWidth: 110.0,
        leading: CircularIconButton(
          icon: Assets.icons.iconArrowLeft.svg(),
          bgColor: AppColors.lightGrey20,
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
          onTap: onBack,
          // onTap: () {
          //   Navigator.pop(context);
          // },
        ),
        actions: actions,
        bottom: bottom,
      ),
      drawer: drawer,
      endDrawer: endDrawer,
      body: body,
    );
  }
}
