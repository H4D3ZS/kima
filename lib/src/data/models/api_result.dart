import 'package:equatable/equatable.dart';

/// Used to map api result and map the data to other layout models
class ApiResult<T> extends Equatable {
  final String? message;
  final dynamic status;
  final dynamic data;

  const ApiResult({
    this.message,
    required this.status,
    required this.data,
  });

  ApiResult copyWith({
    String? message,
    dynamic status,
    dynamic data,
  }) {
    return ApiResult(
      message: message ?? this.message,
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'status': status,
      'data': data,
    };
  }

  factory ApiResult.fromMap(Map<String, dynamic> map) {
    return ApiResult(
      message: map['message'] as String,
      status: map['status'] as dynamic,
      data: map['data'] as dynamic,
    );
  }

  @override
  List<Object?> get props => [message, status, data];
}
