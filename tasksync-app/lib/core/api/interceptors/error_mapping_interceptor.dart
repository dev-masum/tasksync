import 'dart:developer' as developer;
import 'package:app/core/error/failure.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ErrorMappingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final failure = _mapToFailure(err);
    developer.log(
      'API Error [${err.response?.statusCode}] ${err.requestOptions.path}: ${failure.message}',
      name: 'TaskSync.API',
      error: err,
    );

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: failure,
        message: failure.message,
      ),
    );
  }

  Failure _mapToFailure(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = _extractMessage(e);

    if (statusCode == 400) {
      return ServerFailure(message, statusCode, e);
    }

    if (statusCode == 401) {
      return InvalidCredentialsFailure(message, e);
    }

    if (statusCode == 403) {
      return UnauthorizedFailure(message, e);
    }

    if (statusCode == 409) {
      return DuplicateEmailFailure(message, e);
    }

    if (statusCode != null && statusCode >= 500) {
      return ServerFailure(message, statusCode, e);
    }

    return NetworkFailure(
      message.isNotEmpty ? message : (e.message ?? 'Network error occurred'),
      e,
    );
  }

  String _extractMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map<String, dynamic>) {
      if (data['error'] is String && (data['error'] as String).isNotEmpty) {
        return data['error'] as String;
      }
      if (data['message'] is String && (data['message'] as String).isNotEmpty) {
        return data['message'] as String;
      }
    }
    return e.response?.statusMessage ?? e.message ?? 'An error occurred';
  }
}
