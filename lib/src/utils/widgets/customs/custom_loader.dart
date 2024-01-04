import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Show loader that can be used if there's process to avoid other interactions.
void showLoader(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const CustomLoader();
    },
  );
}

/// To close the loader or pop all the dialogs until the main screen is shown
void closeLoader(BuildContext context) {
  Navigator.of(context, rootNavigator: true).pop();
}

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    // Temporary loading indicator instead of black screen
    return const CupertinoActivityIndicator(
      radius: 20.0,
      color: Colors.white,
    );
    // return Container(
    //   color: const Color(0xFF000000),
    //   child: Gif(
    //     autostart: Autostart.loop,
    //     image: const AssetImage(logoGifLoader),
    //     color: const Color(0xFFFFFFFF),
    //   ),
    // );
  }
}
