import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:intl/intl.dart';
import 'package:kima/src/blocs/main/authentication/login/login_bloc/login_bloc.dart';
import 'package:kima/src/blocs/main/authentication/registration/registration_bloc/registration_bloc.dart';
import 'package:kima/src/blocs/main/user/user_bloc.dart';
import 'package:kima/src/data/models/user_profile.dart';
// import 'package:kima/src/screens/Payment/stripe_service.dart';
import 'package:kima/src/screens/authentication/registration/components/registration_account_info.dart';
import 'package:kima/src/screens/authentication/registration/components/registration_account_type.dart';
import 'package:kima/src/screens/authentication/registration/components/registration_app_bar.dart';
import 'package:kima/src/screens/authentication/registration/components/registration_button.dart';
import 'package:kima/src/screens/authentication/registration/components/registration_title.dart';
import 'package:kima/src/screens/root.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/extensions.dart';
import 'package:kima/src/utils/failures/failure_account_already_exist.dart';
import 'package:kima/src/utils/failures/failure_sso_cancelled.dart';
import 'package:kima/src/utils/helpers/print_helpers.dart';
import 'package:kima/src/utils/widgets/customs/custom_loader.dart';
import 'package:kima/src/utils/widgets/customs/custom_snackbar.dart';

import '../../Payment/payment_page.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const route = '/create-account';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  late String _contactNumber = '';

  late RegistrationBloc _registrationBloc;
  late LoginBloc _loginBloc;

  UserTypeEnum _userType = UserTypeEnum.none;

  bool _enableCreate = false;
  bool _isContactNumberValid = false;

  ValidationEnum _emailValidation = ValidationEnum.none;
  ValidationEnum _passwordMatchValidation = ValidationEnum.none;

  @override
  void initState() {
    super.initState();

    _initBloc();
  }

  void _initBloc() {
    _registrationBloc = RegistrationBloc();
    _loginBloc = LoginBloc();
  }

  void _onTextFieldChanged(String? value) {
    _enablingCreate();
  }

  void _onPasswordConfirmationChanged(String? value) {
    final password = _passwordController.text;
    final passwordConfirmation = _passwordConfirmationController.text;

    setState(() {
      if (passwordConfirmation.isNotEmpty && password.isNotEmpty) {
        if (password == passwordConfirmation) {
          _passwordMatchValidation = ValidationEnum.valid;
        } else {
          _passwordMatchValidation = ValidationEnum.invalid;
        }
      } else {
        _passwordMatchValidation = ValidationEnum.none;
      }
    });

    _enablingCreate();
  }

  void _onCreateAccountPressed() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);

    final registration = UserProfile(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      contactNumber: _contactNumber,
      email: _emailController.text.trim(),
      password: _passwordController.text,
      // birthDate: formatted,
      jobTitle: _userType == UserTypeEnum.professional ? 'Driver' : null,
      id: null,
    );

    FocusScope.of(context).unfocus();

    _registrationBloc.add(RegistrationEventNative(
      userProfile: registration,
      userType: _userType,
    ));

    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(),
        ));
  }

  void _onGooglePressed() async {
    FocusScope.of(context).unfocus();
    _loginBloc.add(const LoginEventSso(sso: SsoEnum.google));

    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(),
        ));
  }

  void _onApplePressed() async {
    FocusScope.of(context).unfocus();
    _loginBloc.add(const LoginEventSso(sso: SsoEnum.apple));

    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(),
        ));
  }

  void _onFacebookPressed() async {
    FocusScope.of(context).unfocus();
    _loginBloc.add(const LoginEventSso(sso: SsoEnum.facebook));

    await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PaymentPage(),
        ));
  }

  void _onUserTypeChanged(UserTypeEnum? type) {
    if (type != null) {
      setState(() {
        _userType = type;
      });
    }
  }

  void _enablingCreate() {
    final firstName = _firstNameController.text;
    final lastName = _lastNameController.text;
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final passwordConfirmation = _passwordConfirmationController.text;

    setState(() {
      if (firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          _isContactNumberValid &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          passwordConfirmation.isNotEmpty) {
        if (_userType != UserTypeEnum.none) {
          if (password == passwordConfirmation) {
            _enableCreate = true;

            return;
          }
        }
      }

      _enableCreate = false;
    });
  }

  /// If the email is already exist, will return the validation is invalid
  bool _emailExist() {
    return _emailValidation == ValidationEnum.invalid;
  }

  String get emailErrorMessage {
    if (_emailValidation == ValidationEnum.invalid) {
      return 'Email is already taken';
    } else if (_emailController.text.trim().isEmpty) {
      return '';
    } else if (_emailController.text.trim().isEmailInvalid) {
      return 'Please enter a valid email address';
    } else {
      return '';
    }
  }

  /// If the password matched with passwordConfirmation, will return validation is valid
  bool _passwordMatch() {
    return _passwordMatchValidation == ValidationEnum.valid ||
        _passwordMatchValidation == ValidationEnum.none;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => _registrationBloc,
        ),
        BlocProvider(
          create: (BuildContext context) => _loginBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, regState) {
              if (regState is RegistrationStateLoading) {
                showLoader(context);
              }

              if (regState is RegistrationStateSuccess) {
                closeLoader(context);

                CustomSnackBar.show(
                  context,
                  'New account has been registered',
                );

                Navigator.pop(context);
              }
              if (regState is RegistrationStateFailed) {
                closeLoader(context);

                final failure = regState.failure;

                if (failure is FailureAccountAlreadyExist) {
                  setState(() {
                    _emailValidation = ValidationEnum.invalid;
                  });
                } else {
                  setState(() {
                    _emailValidation = ValidationEnum.none;
                  });

                  CustomSnackBar.show(
                    context,
                    failure.message,
                  );
                }
              }
            },
          ),
          BlocListener<LoginBloc, LoginState>(
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
          ),
        ],
        child: KeyboardVisibilityBuilder(builder: (context, keyboardVisible) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const RegistrationAppBar(),
                            const SizedBox(height: 30.0),
                            const RegistrationTitle(),
                            const SizedBox(height: 20.0),
                            RegistrationAccountType(
                              userTypeEnum: _userType,
                              onUserTypeChanged: _onUserTypeChanged,
                            ),
                            const SizedBox(height: 16.0),
                            RegistrationAccountInfo(
                              firstNameController: _firstNameController,
                              lastNameController: _lastNameController,
                              contactController: _contactController,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              passwordConfirmationController:
                                  _passwordConfirmationController,
                              onFirstNameChanged: _onTextFieldChanged,
                              onLastNameChanged: _onTextFieldChanged,
                              onContactChanged: (contact, isValid) {
                                _contactNumber = contact!;
                                _isContactNumberValid = isValid;
                                _enablingCreate();
                              },
                              onEmailChanged: _onTextFieldChanged,
                              onPasswordChanged: _onTextFieldChanged,
                              onPasswordConfirmationChanged:
                                  _onPasswordConfirmationChanged,
                              errorEmailText: emailErrorMessage,
                              errorPasswordMatchText: !_passwordMatch()
                                  ? 'Password doesn’t match'
                                  : '',
                            ),
                            const SizedBox(height: 40.0),
                            if (!keyboardVisible)
                              RegistrationButton(
                                enable: _enableCreate,
                                onCreateAccountPressed: _onCreateAccountPressed,
                                onGooglePressed: _onGooglePressed,
                                onFacebookPressed: _onFacebookPressed,
                                onApplePressed: _onApplePressed,
                                isProfessionalOrBusiness:
                                    _userType == UserTypeEnum.professional ||
                                        _userType == UserTypeEnum.business,
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
