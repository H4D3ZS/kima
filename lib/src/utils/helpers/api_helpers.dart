import 'dart:convert';

import 'package:http/http.dart';
import 'package:kima/src/data/models/api_result.dart';
import 'package:kima/src/utils/helpers/print_helpers.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/failures/failure.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/exceptions/api_result_exception.dart';
import 'package:http/http.dart' as http;
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';

///ERROR CODES
const String errorIncorrectPassword = 'INCORRECT_PASSWORD';
const String errorAccountNotExist = 'ACCOUNT_DOES_NOT_EXIST';
const String errorAccountAlreadyExist = 'ACCOUNT_ALREADY_EXIST';

/// Get the api result that return ApiResult and used to map in other models
/// [response] HttpResponse from api request
/// [apiName] String name of request to display in logs
ApiResult<T> getApiResult<T>(Response response, {String? apiName}) {
  final status = response.statusCode;
  final data = json.decode(response.body);

  printDebug(response.body);
  printDebug(status);

  if (status == 200) {
    return ApiResult<T>(
      data: data,
      status: status,
    );
  }

  /// If API request is failed
  throw ApiResultException(
    data: data,
    status: status,
    failure: const Failure(),
  );
}

/// Request API
/// [requestType] ApiRequestEnum type of api request
/// [endpoint] String endpoint of api request
/// [requestBody] Map<String, dynamic> body of api request
Future<Response?> httpRequest({
  required ApiRequestEnum requestType,
  required String endpoint,
  Map<String, dynamic>? requestBody,
  Map<String, String>? requestHeader,
  bool withAccessToken = true,
}) async {
  const baseUrl = baseUrlDev;

  final url = Uri.parse(baseUrl + endpoint);

  final accessToken = await readStringSharedPref(spProfileJwt);

  final headers = requestHeader ??
      {
        "Content-Type": "application/x-www-form-urlencoded",
        if (withAccessToken && accessToken != null) ...{
          'authorization': accessToken,
        },
      };
  final encoding = Encoding.getByName('utf-8');
  final body = requestBody;

  switch (requestType) {
    case ApiRequestEnum.delete:
      return await http.delete(url, headers: headers, encoding: encoding, body: body);
    case ApiRequestEnum.get:
      return await http.get(url, headers: headers);
    case ApiRequestEnum.patch:
      return await http.patch(url, headers: headers, encoding: encoding, body: body);
    case ApiRequestEnum.post:
      return await http.post(url, headers: headers, encoding: encoding, body: body);
    case ApiRequestEnum.put:
      return await http.put(url, headers: headers, encoding: encoding, body: body);
    default:
      return null;
  }
}
