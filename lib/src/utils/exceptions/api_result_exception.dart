import 'package:kima/src/utils/failures/failure.dart';

class ApiResultException implements Exception {
  final dynamic data;
  final String? message;
  final int? status;
  final Failure? failure;

  const ApiResultException({this.data, this.message, this.status, this.failure});

  @override
  String toString() {
    return 'ApiResultException{data: $data, message: $message, status: $status, failure: $failure}';
  }
}
