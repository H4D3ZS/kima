import 'package:equatable/equatable.dart';
import 'package:kima/src/utils/strings.dart';

class Failure extends Equatable {
  final String message;
  final int? status;
  final dynamic data;

  const Failure({
    this.message = msgSomethingWentWrong,
    this.status,
    this.data,
  });

  @override
  List<Object?> get props => [
        message,
        status,
        data,
      ];
}
