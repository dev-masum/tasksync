import 'package:app/core/error/failure.dart';
import 'package:dio/dio.dart';

mixin RepoGuard {
  Future<T> guardApiCall<T>(Future<T> Function() fn) async {
    try {
      return await fn();
    } on DioException catch (e) {
      if (e.error is Failure) throw e.error!;
      throw NetworkFailure(e.message ?? 'Network error occurred', e);
    }
  }

  Future<T> guardLocalCall<T>(Future<T> Function() fn) async {
    try {
      return await fn();
    } catch (e) {
      throw StorageFailure('Database operation failed', e);
    }
  }
}
