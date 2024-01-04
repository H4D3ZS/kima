import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kima/src/data/models/api_result.dart';
import 'package:kima/src/data/models/favorite.dart';
import 'package:kima/src/data/models/members.dart';
import 'package:kima/src/utils/configs.dart';
import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/helpers/api_helpers.dart';
import 'package:kima/src/utils/helpers/shared_pref_helpers.dart';

String endPoint = '/members';

class MemberProvider {
  /// Request for members using native
  Future<List<Members>> getMembers() async {
    final response = await httpRequest(
      requestType: ApiRequestEnum.get,
      endpoint: '${endPoint}?page=1&perPage=100',
      withAccessToken: true
    );
    final jsonResponse = json.decode(response!.body);
    List listItems = jsonResponse['data'];
    return listItems.map((x) => Members.fromJson(x)).toList();
  }

  /// Request for favorite
  Future<List<Favorite>> getFavorites() async {
    final response = await httpRequest(
      requestType: ApiRequestEnum.get,
      endpoint: '$endPoint/favorite',
      withAccessToken: true
    );

    List jsonResponse = json.decode(response!.body);
    return jsonResponse.map((x) => Favorite.fromJson({
      ...x,
      'favoriteUser': FavoriteUser.fromJson(x['favoriteUser'])
    })).toList();
  }

  /// Request to favorite profile
  Future<ApiResult> setFavorite({ required int profileID }) async {
    final response = await httpRequest(
      requestType: ApiRequestEnum.post,
      requestBody: {
        'profile_id': profileID.toString()
      },
      endpoint: '$endPoint/favorite',
    );

    return getApiResult(response!);
  }

  /// Request to unfavorite profile
  Future<ApiResult> setUnFavorite({ required int profileID }) async {
    final token = await readStringSharedPref(spProfileJwt);
    final tokenDecoded = JwtDecoder.decode(token!);
    final userID = tokenDecoded['id'];

    final response = await httpRequest(
      requestType: ApiRequestEnum.delete,
      endpoint: '$endPoint/favorite/$userID',
    );

    return getApiResult(response!);
  }

}
