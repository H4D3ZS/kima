import 'package:chopper/chopper.dart';
import 'package:http/http.dart' hide Response, Request;

part 'user_service.chopper.dart';

@ChopperApi()
abstract class UserService extends ChopperService {
  @Get(path: '/members/{id}')
  Future<Response> getById({
    @Header('Authorization') required String token,
    @Path('id') required String id,
  });

  @Put(path: '/members')
  Future<Response> update({
    @Header('Authorization') required String token,
    @Body() required Map<String, dynamic> body,
  });

  @Post(path: '/members/upload/avatar')
  @multipart
  Future<Response> uploadAvatar({
    @Header('Authorization') required String token,
    @PartFile('image') required MultipartFile image,
  });

  @Post(path: '/members/upload/cover')
  @multipart
  Future<Response> uploadCover({
    @Header('Authorization') required String token,
    @PartFile('image') required MultipartFile image,
  });

  @Get(path: '/members')
  Future<Response> getMembers({
    @Header('Authorization') required String token,
    @Query('page') required int page,
    @Query('perPage') required int perPage,
  });

  @Post(path: '/members/daily-status')
  Future<Response> createDailyStatus({
    @Header('Authorization') required String token,
    @Body() required Map<String, dynamic> body,
  });

  @Get(path: '/members/daily-status')
  Future<Response> getAllDailyStatusById({
    @Header('Authorization') required String token,
    @Path('id') String? id,
  });

  @Get(path: '/members/favorite')
  Future<Response> getMyFavorites({
    @Header('Authorization') required String token,
  });

  static UserService create() {
    return _$UserService();
  }


Future<Response> getClientSelectedFavorites({
  @Header('Authorization') required String token,
}) async {

  try {
    final response = await getMyFavorites(token: token);
    return response;
  } catch (error) {
    // Handle errors as needed
    print('Error fetching favorites: $error');
    return Response('GET' as BaseResponse, '/members/favorite', error: 500,);
  }
}}