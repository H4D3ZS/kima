
import 'package:flutter/material.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../utils/widgets/common/button_widget.dart';

class ProfileQRCodeScreen extends StatefulWidget {
  const ProfileQRCodeScreen({super.key});

  static const route = '/profile/qr_code';

  @override
  State<ProfileQRCodeScreen> createState() => _ProfileQRCodeScreenState();
}

class _ProfileQRCodeScreenState extends State<ProfileQRCodeScreen> {
  /// For QR Code
  final GlobalKey _qrGlobalKey = GlobalKey();
  String _strQRCodeFormat = '';

  @override
  void initState() {
    super.initState();
    _strQRCodeFormat = 'Rafael Desuyo\'s Profile';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create QR Code',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        // elevation: 0,
        // titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.grey,
          ),
          tooltip: 'close',
          onPressed: () async {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30,),
              RepaintBoundary(
                key: _qrGlobalKey,
                child: QrImageView(
                  data: _strQRCodeFormat,
                  version: QrVersions.auto,
                  backgroundColor: AppColors.primaryColor,
                  size: MediaQuery.of(context).size.width / 2,
                ),
              ),
              const SizedBox(height: 20,),
              Text(
                'Rafael Desuyo\'s Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ButtonWidget(
                onTap: () async {
                },
                title: 'Share QR Code',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                textColor: Colors.white,
                buttonWidth: double.infinity,
                buttonHeight: 30,
                buttonColor: AppColors.primaryColor,
                borderRadius: 20,
              ),
              ButtonWidget(
                onTap: () async {
                },
                title: 'Save as Image',
                fontSize: 15,
                fontWeight: FontWeight.bold,
                textColor: AppColors.primaryColor,
                buttonWidth: double.infinity,
                buttonHeight: 30,
                buttonColor: Colors.black,
                borderColor: AppColors.primaryColor,
                borderWidth: 2,
                borderRadius: 20,
                margin: const EdgeInsets.only(top: 10, bottom: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
