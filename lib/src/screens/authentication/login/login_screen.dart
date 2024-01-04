import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kima/src/blocs/main/authentication/login/login_bloc/login_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/screens/Payment/payment_page.dart';
import 'package:kima/src/screens/authentication/login/components/login_buttons.dart';
import 'package:kima/src/screens/authentication/login/components/login_text_fields.dart';
import 'package:kima/src/screens/authentication/login/components/login_title.dart';
import 'package:kima/src/screens/authentication/registration/registration_screen.dart';
import 'package:kima/src/screens/root.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/failures/failure_sso_cancelled.dart';
import 'package:kima/src/utils/helpers/print_helpers.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const route = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  bool _enableLogin = false;

  @override
  void initState() {
    super.initState();

    _initBloc();
  }

  void _initBloc() {
    _loginBloc = LoginBloc();
  }

  void _onPasswordRecoveryPressed() {}

  void _onSignUpPressed() {
    FocusScope.of(context).unfocus();
    Navigator.pushNamed(context, RegistrationScreen.route);
  }

  void _onLoginPressed() {
    final email = _emailController.text;
    final password = _passwordController.text;

    FocusScope.of(context).unfocus();
    _loginBloc.add(LoginEventNative(email: email, password: password));
  }

  void _onLoginByGooglePressed() async {
    FocusScope.of(context).unfocus();
    _loginBloc.add(const LoginEventSso(sso: SsoEnum.google));

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(),
      ),
    );
  }

  void _onLoginByApplePressed() async {
    FocusScope.of(context).unfocus();
    _loginBloc.add(const LoginEventSso(sso: SsoEnum.apple));

    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(),
        ));
  }

  void _onLoginByFacebookPressed() async {
    FocusScope.of(context).unfocus();
    _loginBloc.add(const LoginEventSso(sso: SsoEnum.facebook));

    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(),
        ));
  }

  void _onEmailChanged(String? value) {
    _enablingLogin();
  }

  void _onPasswordChanged(String? value) {
    _enablingLogin();
  }

  void _enablingLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      if (email.isNotEmpty && password.isNotEmpty) {
        _enableLogin = true;
      } else {
        _enableLogin = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, loginState) {
          if (loginState is LoginStateLoading) {
            showLoader(context);
          }
          if (loginState is LoginStateSuccess) {
            BlocProvider.of<UserBloc>(context)
                .add(SetCurrentUserEvent(loginState.user));
            closeLoader(context);
            Navigator.pushReplacementNamed(context, Root.route);
          }
          if (loginState is LoginStateFailed) {
            closeLoader(context);

            final failure = loginState.failure;
            printDebug(failure);

            if (failure is! FailureSsoCancelled) {
              CustomSnackBar.error(
                context,
                failure.message,
              );
            }
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: const Color(0xFF38CC96),
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  const LoginTitle(),
                  LoginTextFields(
                    emailController: _emailController,
                    passwordController: _passwordController,
                    onEmailChanged: _onEmailChanged,
                    onPasswordChanged: _onPasswordChanged,
                  ),
                  LoginButtons(
                    enableLogin: _enableLogin,
                    onPasswordRecoveryPressed: _onPasswordRecoveryPressed,
                    onLoginPressed: _onLoginPressed,
                    onSignUpPressed: _onSignUpPressed,
                    onGooglePressed: _onLoginByGooglePressed,
                    onApplePressed: _onLoginByApplePressed,
                    onFacebookPressed: _onLoginByFacebookPressed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
