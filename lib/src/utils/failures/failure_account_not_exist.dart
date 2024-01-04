import 'package:kima/src/utils/failures/failure.dart';

class FailureAccountNotExist extends Failure {
  const FailureAccountNotExist({
    super.message = 'Account doesn’t exist',
  });
}
