import 'package:kima/src/utils/enums.dart';
import 'package:kima/src/utils/helpers/api_helpers.dart';
class CResponse {
  bool? success;
  String? message;
}

class ChatProvider {
  /// Request for chat user
  Future sendMessage(Map<String, dynamic> requestBody) async {
    dynamic payload = {
      'recipientUid': requestBody['recipient'].toString(),
      'message': requestBody['message'].toString()
    };
    final response = await httpRequest(
      requestType: ApiRequestEnum.post,
      endpoint: '/chat/send-message',
      requestBody: payload,
      withAccessToken: true
    );
    print(response!.statusCode);
  }
}