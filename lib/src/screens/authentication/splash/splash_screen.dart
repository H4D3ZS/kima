import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/src/blocs/main/splash/splash_bloc/splash_bloc.dart';
import 'package:kima/src/screens/authentication/login/login_screen.dart';
import 'package:kima/src/screens/authentication/splash/components/splash_buttons.dart';
import 'package:kima/src/screens/authentication/splash/components/splash_title.dart';
import 'package:kima/src/utils/helpers/print_helpers.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const route = '/';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashBloc _splashBloc;
  late Future _googleFontsPending;

  @override
  void initState() {
    super.initState();

    _googleFontsPending = GoogleFonts.pendingFonts([
      GoogleFonts.poppins(),
    ]);

    _initBloc();
  }

  void _initBloc() {
    _splashBloc = SplashBloc();
  }

  void _onGetStartedPressed() {
    Navigator.pushReplacementNamed(context, LoginScreen.route);
  }

  void _onLearnMorePressed() {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _splashBloc,
      child: Scaffold(
        backgroundColor: const Color(0xFF000000),
        body: FutureBuilder(
          future: _googleFontsPending,
          builder: (context, snapshot) {
            printDebug(snapshot.connectionState);

            if (snapshot.connectionState == ConnectionState.done) {
              return BlocBuilder<SplashBloc, SplashState>(
                builder: (context, splashState) {
                  return Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SplashTitle(),
                        SplashButtons(
                          onGetStartedPressed: _onGetStartedPressed,
                          onLearnMorePressed: _onLearnMorePressed,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const Center(
              child: CustomLoader(),
            );
          },
        ),
      ),
    );
  }
}
