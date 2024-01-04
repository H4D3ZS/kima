import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key});

  static const route = '/qr-code';

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  GlobalKey globalKey = GlobalKey();
  String? qrCodeError;

  Future<void> _saveOrShareQRCodeAsImage(QrAction action, UserProfile user) async {
    try {
      RenderRepaintBoundary boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 5.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        if (action == QrAction.save) await ImageGallerySaver.saveImage(pngBytes);

        if (action == QrAction.share) {
          final tempDir = await getTemporaryDirectory();
          final name = '${user.displayName.toLowerCase().splitMapJoin(' ', onMatch: (_) => '-')}-QR.png';

          final file = await File('${tempDir.path}/$name').create();
          final qrFile = await file.writeAsBytes(pngBytes);
          await Share.shareUri(Uri.file(qrFile.path));
        }
      } else {
        qrCodeError = 'Could not generate QR Code as image';
      }
    } catch (e) {
      qrCodeError = 'Something went wrong. ${e.toString()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProfile user = ModalRoute.of(context)?.settings.arguments as UserProfile;
    return Scaffold(
      backgroundColor: AppColors.black20,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  CircularIconButton(
                    onTap: () => Navigator.pop(context),
                    icon: Assets.icons.iconExit.svg(),
                    bgColor: AppColors.black20,
                    borderColor: AppColors.lightGrey10,
                    width: 50.0,
                    height: 50.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Center(
                      child: Text(
                        'Account QR Code',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const VerticalSpace(80.0),
              Center(
                child: RepaintBoundary(
                  key: globalKey,
                  child: Container(
                    color: AppColors.black20,
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                    child: QrImageView(
                      data: user.userDeepLinkUri.toString(),
                      foregroundColor: AppColors.green,
                      backgroundColor: AppColors.black20,
                      size: 280,
                      embeddedImageStyle: const QrEmbeddedImageStyle(
                        size: Size(
                          100,
                          100,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const VerticalSpace(40),
              Center(
                child: Text(
                  "${user.firstName}'s Profile",
                  style: GoogleFonts.poppins(fontSize: 22.0, fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
              const VerticalSpace(50),
              InkWell(
                onTap: () {
                  _saveOrShareQRCodeAsImage(QrAction.share, user);
                  if (qrCodeError != null) CustomSnackBar.error(context, qrCodeError!);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Text(
                    'Share QR Code',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ),
              const VerticalSpace(20),
              InkWell(
                onTap: () {
                  _saveOrShareQRCodeAsImage(QrAction.save, user);
                  qrCodeError != null
                      ? CustomSnackBar.error(context, qrCodeError!)
                      : CustomSnackBar.show(context, 'QR Code saved as image');
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: AppColors.green),
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Text(
                    'Save as Image',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: AppColors.green,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
