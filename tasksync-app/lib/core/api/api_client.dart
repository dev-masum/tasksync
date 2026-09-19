import 'package:app/config/config.dart';
import 'package:app/core/api/api_endpoints.dart';
import 'package:app/core/api/interceptors/auth_interceptor.dart';
import 'package:app/core/api/interceptors/error_mapping_interceptor.dart';
import 'package:app/core/api/interceptors/logging_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiClient {
  final Dio dio;

  final AuthInterceptor authInterceptor;
  final LoggingInterceptor loggingInterceptor;
  final ErrorMappingInterceptor errorMappingInterceptor;

  ApiEndpoints? _apiEndpoints;

  ApiClient(
    this.dio, {
    required this.authInterceptor,
    required this.loggingInterceptor,
    required this.errorMappingInterceptor,
  }) {
    dio.options.baseUrl = TasksyncConfig.baseUrl;
    dio.options.connectTimeout = TasksyncConfig.connectTimeout;
    dio.options.receiveTimeout = TasksyncConfig.receiveTimeout;

    dio.interceptors.add(loggingInterceptor);
    dio.interceptors.add(authInterceptor);
    dio.interceptors.add(errorMappingInterceptor);
  }

  ApiEndpoints get endpoints =>
      _apiEndpoints ??= ApiEndpoints(dio, baseUrl: dio.options.baseUrl);
}
