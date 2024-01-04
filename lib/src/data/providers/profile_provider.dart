import 'dart:io';

import 'package:kima/src/data/models/api_result.dart';
import 'package:kima/src/data/models/user_profile.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/helpers/api_helpers.dart';
import 'package:http/http.dart' as http;

class ProfileProvider {
  /// Request for profile using native
  Future<ApiResult> editProfileNative({
    required UserProfile profile,
  }) async {
    final id = profile.id;
    final response = await httpRequest(
      requestType: ApiRequestEnum.put,
      requestBody: {
        'full_name': profile.firstName,
        'contact_number': profile.contactNumber,
      },
      endpoint: 'endpointProfile/$id',
    );

    return getApiResult(response!);
  }

  Future<ApiResult> editAvatarNative({
    required File avatar,
  }) async {
    const String endpoint = '/members/profile/upload';

    final request =
        http.MultipartRequest('POST', Uri.parse(baseUrlDev + endpoint));
    // request.fields['id'] = memberId.toString();
    request.files.add(http.MultipartFile.fromBytes(
        '/images/', File(avatar.path).readAsBytesSync(),
        filename: avatar.path));
    final response = await request.send();

    // await httpRequest(
    //   requestType: ApiRequestEnum.put,
    //   requestBody: profile.toJson()..removeWhere((key, value) => value == null),
    //   endpoint: endpointAvatar,
    // );

    return getApiResult(response as http.Response);
  }
}
