import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/firebase_options.dart';
import 'package:kima/src/app.dart';
import 'package:kima/src/app_bloc_observer.dart';
import 'package:kima/src/screens/marketplace/classifieds_description_screen.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  // This makes sure that the widgets are initialized before the app runs.
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'kima-app',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Stripe.publishableKey =
      "pk_live_51NkM0pFcfThzV7D6sSiKdWATnwgwpVIJYNEO3G7rAEmEqGPzfkEQjA7o5cXv6hvYu1YAp9nvJUfTXJIcBgnr63bJ00H5OQZHlU";

  // Set the app's bloc observer to AppBlocObserver.
  Bloc.observer = AppBlocObserver();

  runApp(const App(
    flavor: AppFlavorsEnum.dev,
  ));

  ;
}
