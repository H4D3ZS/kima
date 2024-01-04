import 'package:chopper/chopper.dart';
import 'package:http/http.dart' hide Response, Request;

part 'classifieds_service.chopper.dart';

@ChopperApi()
abstract class ClassifiedsService extends ChopperService {
  @Get(path: '/classifieds')
  Future<Response> getClassifieds({
    @Header('Authorization') required String token,
    @Query('page') required int page,
    @Query('perPage') required int perPage,
  });

  @Post(path: '/classifieds/{category}')
  Future<Response> createClassifieds({
    @Header('Authorization') required String token,
    @Path('category') required String category,
    @Body() required Map<String, dynamic> body,
  });

  @Post(path: '/classifieds/{id}/upload/gallery')
  @multipart
  Future<Response> uploadGallery({
    @Header('Authorization') required String token,
    @Path('id') required int id,
    @PartFile('images') required List<MultipartFile> images,
  });

  static ClassifiedsService create() {
    return _$ClassifiedsService();
  }
}
