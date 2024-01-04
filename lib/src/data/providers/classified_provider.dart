import 'dart:convert';
import 'dart:io';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kima/src/data/models/api_result.dart';
import 'package:kima/src/data/models/classifieds_model.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/helpers/api_helpers.dart';
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';
import 'package:http/http.dart' as http;

String endPoint = '/classifieds';

class ClassifiedProvider {
  /// Request for classifieds using native
  Future<List<Classified>> getClassifieds() async {
    final response = await httpRequest(
      requestType: ApiRequestEnum.get,
      endpoint: endPoint,
      withAccessToken: true
    );
    final jsonResponse = json.decode(response!.body);
    List listItems = jsonResponse['data'];
    return listItems.map((x) => Classified.fromJson(x)).toList();
  }

  /// Request to Post classified
  Future<ApiResult> postClassified<T>(String type, {
    required Map<String, dynamic> requestBody
  }) async {
    final token = await readStringSharedPref(spProfileJwt);
    final tokenDecoded = JwtDecoder.decode(token!);
    final userID = tokenDecoded['id'];
    
    final response = await httpRequest(
      requestType: ApiRequestEnum.post,
      endpoint: '$endPoint/$type',
      requestBody: requestBody,
      withAccessToken: true
    );

    return getApiResult(response!);
  }

  Future<ApiResult> uploadImageClassified(List<dynamic> listImages) async {
    final request = http.MultipartRequest('POST', Uri.parse(baseUrlDev + endPoint));
    for (var i = 0; i < listImages.length; i++) {
      request.files.add(http.MultipartFile.fromBytes('/images/', File(listImages[i].path).readAsBytesSync())); 
    }
    final response = await request.send();

    return getApiResult(response as http.Response);
  }

}
