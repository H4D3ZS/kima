import 'dart:async';
import 'dart:convert';
import 'package:chopper/chopper.dart';
import 'package:crypto/crypto.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/data/services/authentication_service.dart';
import 'package:kima/src/data/services/user_service.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/failures/failure.dart';
import 'package:kima/src/utils/exceptions/api_result_exception.dart';
import 'package:kima/src/utils/failures/failure_sso_cancelled.dart';
import 'package:kima/src/utils/helpers/print_helpers.dart';
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginStateInitial()) {
    on<LoginEventNative>(_onEventNative);
    on<LoginEventSso>(_onEventSso);
  }

  final _chopper = ChopperClient(
    baseUrl: Uri.parse(baseUrlDev),
    converter: const JsonConverter(),
    services: [
      AuthenticationService.create(),
      UserService.create(),
    ],
  );

  @override
  Future close() {
    _chopper.dispose();

    return super.close();
  }

  Future<void> _onEventNative(
    LoginEventNative event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginStateLoading());

    try {
      final email = event.email;
      final password = event.password;

      final auth = await _chopper.getService<AuthenticationService>().postLoginNative(
            email: email,
            password: password,
          );

      if (!auth.isSuccessful) throw ApiResultException(message: json.decode(auth.bodyString)['message']);

      final token = auth.headers['authorization'];
      final id = JwtDecoder.decode(token!)['id'];

      await setStringSharedPref(spProfileJwt, token);

      final response = await _chopper.getService<UserService>().getById(token: token, id: id);
      final user = UserProfile.fromJson(response.body);

      emit(LoginStateSuccess(user));
    } on ApiResultException catch (e) {
      final error = e.message;

      if (error != null) {
        emit(LoginStateFailed(Failure(message: error)));
      } else {
        emit(const LoginStateFailed(Failure()));
      }
    } catch (e, stackTrace) {
      printCatch(e, stackTrace, runtimeType);
      emit(const LoginStateFailed(Failure()));
    }
  }

  Future<void> _onEventSso(
    LoginEventSso event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginStateLoading());
    try {
      final sso = event.sso;
      UserCredential? userCredentials;

      if (sso == SsoEnum.google) {
        userCredentials = await _googleUserCredentials();
      } else if (sso == SsoEnum.apple) {
        userCredentials = await _appleUserCredentials();
      } else if (sso == SsoEnum.facebook) {
        userCredentials = await _facebookUserCredentials();
      } else {
        emit(const LoginStateFailed(Failure()));
        return;
      }

      if (userCredentials != null) {
        final firebaseToken = await userCredentials.user?.getIdToken();

        if (firebaseToken != null) {
          final auth = await _chopper.getService<AuthenticationService>().postLoginSso(token: firebaseToken);

          if (!auth.isSuccessful) throw ApiResultException(message: json.decode(auth.bodyString)['message']);

          final token = auth.headers['authorization'];
          final id = JwtDecoder.decode(token!)['id'];

          await setStringSharedPref(spProfileJwt, token);

          final response = await _chopper.getService<UserService>().getById(token: token, id: id);
          final user = UserProfile.fromJson(response.body);

          emit(LoginStateSuccess(user));
        }
      } else {
        emit(const LoginStateFailed(FailureSsoCancelled()));
      }
    } on ApiResultException catch (e) {
      final error = e.message;

      if (error != null) {
        emit(LoginStateFailed(Failure(message: error)));
      } else {
        emit(const LoginStateFailed(Failure()));
      }
    } catch (e, stackTrace) {
      printCatch(e, stackTrace, runtimeType);
      emit(const LoginStateFailed(Failure()));
    }
  }

  /// To call google SSO that returns user credential
  Future<UserCredential?> _googleUserCredentials() async {
    final google = GoogleSignIn();

    /// Trigger the authentication flow
    await google.signOut();
    final googleUser = await google.signIn();

    if (googleUser == null) {
      return null;
    }

    /// Obtain the auth details from the request
    final googleAuth = await googleUser.authentication;

    /// Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // return googleAuth;
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  /// To call apple SSO that returns user credential
  Future<UserCredential?> _appleUserCredentials() async {
    /// To prevent replay attacks with the credential returned from Apple, we include a nonce in the credential request.
    /// When signing in with Firebase, the nonce in the id token returned by Apple, is expected to  match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = _sha256ofString(rawNonce);

    /// Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    /// Create an `OAuthCredential` from the credential returned by Apple.
    final credential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> _facebookUserCredentials() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.accessToken != null) {
      // Create a credential from the access token
      final facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    }

    return null;
  }
}
