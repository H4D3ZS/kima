import 'package:flutter/material.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/screens/qrcode/qr_code_scanner_overlay.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/_common.dart';
import 'package:kima/src/utils/widgets/customs/custom_text.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher_string.dart';

class QRCodeScannerScreen extends StatefulWidget {
  static const route = 'qr/scan';

  const QRCodeScannerScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScannerScreen> createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  late MobileScannerController _scannerController;
  bool _screenOpened = false;

  @override
  void initState() {
    _scannerController = MobileScannerController(detectionSpeed: DetectionSpeed.noDuplicates);
    super.initState();
  }

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(context).clearSnackBars();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Scan QR Code',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            elevation: 2.0,
            shadowColor: const Color(0xFFC3C3D1).withOpacity(0.25),
            toolbarHeight: 130.0,
            leadingWidth: 110.0,
            leading: CircularIconButton(
              icon: Assets.icons.iconArrowLeft.svg(),
              bgColor: AppColors.lightGrey20,
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              onTap: () {
                ScaffoldMessenger.of(context).clearSnackBars();
                Navigator.pop(context);
              },
            ),
          ),
          body: Stack(
            children: [
              MobileScanner(
                controller: _scannerController,
                onDetect: _foundBarcode,
              ),
              QRCodeScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
            ],
          ),
        ),
      );

  void _foundBarcode(BarcodeCapture value) {
    if (!_screenOpened) {
      final List<Barcode> barcodes = value.barcodes;

      for (final barcode in barcodes) {
        final code = barcode.rawValue;

        ScaffoldMessenger.of(context).clearSnackBars();

        _screenOpened = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(40.0),
            elevation: 20.0,
            shape: const StadiumBorder(),
            backgroundColor: AppColors.white5,
            duration: const Duration(days: 1),
            content: InkWell(
              onTap: () {
                launchUrlString(code);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).clearSnackBars();
              },
              child: CustomText(
                code!.contains('deeplink://') ? 'Go to profile' : code,
                alignment: TextAlign.center,
                fontColor: AppColors.green,
              ),
            ),
          ),
        );
      }
    }
  }
}
