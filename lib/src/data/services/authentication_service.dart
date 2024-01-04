import 'package:chopper/chopper.dart';

part 'authentication_service.chopper.dart';

@ChopperApi()
abstract class AuthenticationService extends ChopperService {
  @Post(path: '/auth/login')
  Future<Response> postLoginNative({
    @Field('email') required String email,
    @Field('password') required String password,
  });

  @Post(path: '/auth/login', optionalBody: true)
  Future<Response> postLoginSso({
    @Header('firebase-token') required String token,
  });

  @Post(path: '/members/{type}')
  Future<Response> postRegistrationNative({
    @Path('type') required String type,
    @Body() required Map<String, dynamic> body,
  });

  static AuthenticationService create() {
    return _$AuthenticationService();
  }
}
