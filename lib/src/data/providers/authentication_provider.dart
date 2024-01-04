import 'package:firebase_auth/firebase_auth.dart';
import 'package:kima/src/data/models/api_result.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/helpers/api_helpers.dart';
import 'package:kima/src/utils/helpers/print_helpers.dart';

class AuthenticationProvider {
  /// Request for login using native
  Future<ApiResult> loginNative({
    required String email,
    required String password,
  }) async {
    final response = await httpRequest(
      requestType: ApiRequestEnum.post,
      requestBody: {
        'email': email,
        'password': password,
      },
      endpoint: endpointLogin,
      withAccessToken: false,
    );

    return getApiResult(response!);
  }

  Future<ApiResult> loginSso({
    required UserCredential credential,
  }) async {
    final authentication = await credential.user!.getIdToken();
    printDebug(authentication, title: 'AccessToken');


    final response = await httpRequest(
      requestType: ApiRequestEnum.post,
      requestHeader: {
        'Authorization': 'Bearer $authentication',
        'Content-Type': 'application/json',
      },
      endpoint: endpointLogin,
      withAccessToken: false,
    );

    return getApiResult(response!);
  }

  /// Request for registration using native
  Future<ApiResult> registrationNative({
    required UserProfile registration,
    required UserTypeEnum userType,
  }) async {
    var endpoint = 'endpointRegistrationStandard';

    final response = await httpRequest(
      requestType: ApiRequestEnum.post,
      requestBody: registration.toJson()..removeWhere((key, value) => value == null),
      endpoint: endpoint,
      withAccessToken: false,
    );

    return getApiResult(response!);
  }

  /// Request for logout app
  Future<ApiResult> logout() async {
    final response = await httpRequest(
      requestType: ApiRequestEnum.post,
      endpoint: '/logout',
      withAccessToken: true
    );

    return getApiResult(response!);
  }
}
