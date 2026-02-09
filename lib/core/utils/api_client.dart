import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:search_frontend/core/constants/index.dart';

import '../errors/exceptions.dart';

class ApiClient {
  final Dio _dio;
  String? _token;

  ApiClient()
    : _dio = Dio(
        BaseOptions(
          baseUrl: API_URL,
          validateStatus: (status) => status! < 500,
          connectTimeout: Duration(seconds: 10),
          receiveTimeout: Duration(seconds: 10),

          headers: {'Content-Type': 'application/json'},
        ),
      ) {
    _dio.interceptors.add(
      LogInterceptor(
        request: true,
        // requestBody: true,
        // responseBody: true,
        // responseHeader: false,
        error: true,
      ),
    );
  }

  void setToken(String token) {
    _token = token;
    _dio.options.headers['Authorization'] = "Bearer $token";
  }

  Future<T> post<T>(
    String path, {
    dynamic data,
    Options? options,
    Function(int sent, int total)? onSendProgress,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
      );
      return _processResponse(response) as T;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  Future<T> patch<T>(String path, {dynamic data}) async {
    try {
      final response = await _dio.patch(path, data: data);
      return _processResponse(response) as T;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  Future<T> get<T>(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return _processResponse(response) as T;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  Future<T> delete<T>(String path) async {
    try {
      final response = await _dio.delete(path);
      return _processResponse(response) as T;
    } on DioException catch (e) {
      _handleDioException(e);
    }
  }

  Never _handleDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw TimeoutException("Превышено время ожидания запроса");

      case DioExceptionType.sendTimeout:
        throw TimeoutException("Истек таймаут отправки данных");

      case DioExceptionType.receiveTimeout:
        throw TimeoutException("Превышено время ожидания запроса");

      case DioExceptionType.badCertificate:
        throw ServerException(
          "Сертификат сервера недействителен",
          statusCode: e.response?.statusCode,
        );

      case DioExceptionType.badResponse:
        return _handleHttpError(e.response!);

      case DioExceptionType.cancel:
        throw NetworkException("Запрос был отменен");

      case DioExceptionType.connectionError:
        throw NetworkException("Ошибка подключения к серверу");

      case DioExceptionType.unknown:
        throw UnknownException(
          e.message ?? "Неизвестная ошибка Dio",
          statusCode: e.response?.statusCode,
        );
    }
  }

  dynamic _processResponse(Response response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      if (response.data is String) {
        return jsonDecode(response.data); // может быть Map или List
      } else if (response.data is Map<String, dynamic> ||
          response.data is List) {
        return response.data;
      } else {
        throw UnknownFormatException();
      }
    } else {
      _handleHttpError(response);
    }
  }

  Never _handleHttpError(Response response) {
    final message = response.data?['message'] ?? 'Unknown error';
    switch (response.statusCode) {
      case 401:
        throw UnauthorizedException(message, statusCode: response.statusCode);
      case 403:
        throw ForbiddenException(message, statusCode: response.statusCode);
      case 404:
        throw NotFoundException(message, statusCode: response.statusCode);
      case 500:
        throw ServerException(message, statusCode: response.statusCode);
      default:
        throw UnknownException(message, statusCode: response.statusCode);
    }
  }
}
