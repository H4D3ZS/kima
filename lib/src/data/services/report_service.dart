import 'package:chopper/chopper.dart';

part 'report_service.chopper.dart';

@ChopperApi()
abstract class ReportService extends ChopperService {
  @Post(path: '/reports/user')
  Future<Response> reportUser({
    @Header('Authorization') required String token,
    @Body() required Map<String, dynamic> body,
  });

  @Post(path: '/reports/classified')
  Future<Response> reportClassified({
    @Header('Authorization') required String token,
    @Body() required Map<String, dynamic> body,
  });

  static ReportService create() {
    return _$ReportService();
  }
}
