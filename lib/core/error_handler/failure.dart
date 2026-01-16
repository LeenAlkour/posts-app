abstract class Failure {
  final String message;
  final int? code;

  const Failure(this.message, [this.code]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'No Internet connection']);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error']);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = 'Request timed out']);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure([super.message = 'Unexpected error']);
}
