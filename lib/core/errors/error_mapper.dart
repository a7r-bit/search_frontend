import 'dart:developer';

import 'package:search_frontend/core/domain/failures/failure.dart';

import 'exceptions.dart';

Failure mapExceptionToFailure(Exception e) {
  log(e.toString());
  if (e is UnauthorizedException) {
    return Failure(
      e.message == "Невалидные данные токена"
          ? "Невалидные данные токена"
          : "Неверный логин или пароль ",
      code: e.statusCode,
    );
  }
  if (e is ForbiddenException) {
    return Failure(e.message, code: e.statusCode);
  }
  if (e is ServerException) {
    return Failure(e.message, code: e.statusCode);
  }
  if (e is NotFoundException) {
    return Failure(e.message, code: e.statusCode);
  }
  if (e is UnknownException) {
    return Failure(e.message, code: e.statusCode);
  }
  if (e is NetworkException) {
    return Failure(e.message, code: e.statusCode);
  }
  if (e is TimeoutException) {
    return Failure(e.message, code: e.statusCode);
  }
  return Failure("Неизвестная ошибка");
}
