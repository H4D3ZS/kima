import 'package:kima/src/utils/failures/failure.dart';

class FailureInvalidCredentials extends Failure {
  const FailureInvalidCredentials({
    super.message = 'Wrong password',
  });
}
