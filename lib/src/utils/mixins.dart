import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/screens/dashboard/profile/dashboard_regular_profile/dashboard_regular_profile_screen.dart';
import 'package:kima/src/screens/qrcode/qr_code_screen.dart';
import 'package:kima/src/screens/report/report_screen.dart';
import 'package:kima/src/screens/report/report_success_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';
import 'package:share_plus/share_plus.dart';

import 'widgets/common/_common.dart';

mixin DialogMixins {
  void showReportModalBottomSheet(BuildContext context, {required String text, required ReportType type}) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext builder) {
        return Container(
          height: 385.0,
          padding: const EdgeInsets.all(30.0),
          decoration: const BoxDecoration(
            color: AppColors.black20,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 30.0),
                    width: 70.0,
                    height: 5.0,
                    decoration: const BoxDecoration(
                      color: AppColors.lightGrey5,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  const VerticalSpace(30.0),
                  Assets.icons.checkCircle.svg(),
                  const VerticalSpace(20.0),
                  const CustomText(
                    'You selected',
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    fontColor: Colors.white,
                  ),
                  const VerticalSpace(15.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: AppColors.green.withOpacity(0.48),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: CustomText(
                      text,
                      fontSize: 14.0,
                      fontColor: AppColors.green,
                    ),
                  ),
                  const VerticalSpace(16.0),
                  const CustomText(
                    'If you think this profile goes against our Community Standards, please also report it. You may want to block this profile instead.',
                    alignment: TextAlign.center,
                    style: TextStyle(
                      height: 1.2,
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const VerticalSpace(60.0),
                  ButtonWidget(
                    onTap: () async {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, ReportSuccessScreen.route, arguments: type);
                    },
                    title: 'Done',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    buttonHeight: 45.0,
                    buttonColor: AppColors.green,
                    borderRadius: 20.0,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showShareModalBottomSheet(BuildContext context, UserProfile user) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext builder) {
        return Container(
          height: 275.0,
          padding: const EdgeInsets.all(30.0),
          decoration: const BoxDecoration(
            color: AppColors.black20,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      width: 70.0,
                      height: 5.0,
                      decoration: const BoxDecoration(
                        color: AppColors.lightGrey5,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  const VerticalSpace(20.0),
                  Text(
                    'Share Options',
                    style: GoogleFonts.poppins(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                  const VerticalSpace(20.0),
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Assets.icons.iconCopyLink.svg(),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Copy link',
                            style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white),
                          ),
                        ],
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, QRCodeScreen.route, arguments: user);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Assets.icons.iconQr.svg(),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Create QR code',
                              style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      await Share.shareUri(user.userDeepLinkUri);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Assets.icons.iconShare.svg(),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Share via ...',
                              style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showDescriptionModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext builder) {
        return Container(
          height: 300.0,
          padding: const EdgeInsets.all(30.0),
          decoration: const BoxDecoration(
            color: AppColors.black20,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
          ),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      width: 70.0,
                      height: 5.0,
                      decoration: const BoxDecoration(
                        color: AppColors.lightGrey5,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  const VerticalSpace(20.0),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, DashboardRegularProfileScreen.route);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Assets.icons.iconModalHelp.svg(),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'View User Profile',
                              style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ReportScreen.route);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Assets.icons.iconModalHelp.svg(),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Report User',
                              style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, ReportScreen.route);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Assets.icons.iconModalHelp.svg(),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Report Post',
                              style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            Assets.icons.iconShare.svg(),
                            const SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Share post via ...',
                              style: GoogleFonts.poppins(fontSize: 18.0, color: Colors.white),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void showImagePickerBottomSheet(
    BuildContext context, {
    required VoidCallback onSelectCamera,
    required VoidCallback onSelectGallery,
  }) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => onSelectCamera(),
            child: const Text('Take photo'),
          ),
          CupertinoActionSheetAction(
            onPressed: () => onSelectGallery(),
            child: const Text('Open gallery'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          child: const Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}
