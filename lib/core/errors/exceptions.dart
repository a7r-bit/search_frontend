class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, {this.statusCode});
}

class UnauthorizedException extends ServerException {
  UnauthorizedException(super.message, {super.statusCode});
}

class ForbiddenException extends ServerException {
  ForbiddenException(super.message, {super.statusCode});
}

class NotFoundException extends ServerException {
  NotFoundException(super.message, {super.statusCode});
}

class UnknownException extends ServerException {
  UnknownException(super.message, {super.statusCode});
}

class NetworkException extends ServerException {
  NetworkException(super.message);
}

class TimeoutException extends ServerException {
  TimeoutException(super.message);
}

class UnknownFormatException extends ServerException {
  UnknownFormatException() : super("Unknown response format");
}
