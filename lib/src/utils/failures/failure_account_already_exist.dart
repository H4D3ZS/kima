import 'package:kima/src/utils/failures/failure.dart';

class FailureAccountAlreadyExist extends Failure {
  const FailureAccountAlreadyExist({
    super.message = 'Account already exist',
  });
}
