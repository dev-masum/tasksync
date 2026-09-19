sealed class Failure implements Exception {
  final String message;
  final dynamic cause;

  const Failure(this.message, [this.cause]);

  @override
  String toString() => 'Failure: $message${cause != null ? ' ($cause)' : ''}';
}

class ServerFailure extends Failure {
  final int? statusCode;
  const ServerFailure(super.message, [this.statusCode, super.cause]);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message, [super.cause]);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure(super.message, [super.cause]);
}

class InvalidCredentialsFailure extends Failure {
  const InvalidCredentialsFailure(super.message, [super.cause]);
}

class DuplicateEmailFailure extends Failure {
  const DuplicateEmailFailure(super.message, [super.cause]);
}

class StorageFailure extends Failure {
  const StorageFailure(super.message, [super.cause]);
}

class DeviceFailure extends Failure {
  const DeviceFailure(super.message, [super.cause]);
}
