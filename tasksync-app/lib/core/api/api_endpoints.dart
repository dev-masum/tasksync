import 'package:app/core/api/models/api_response.dart';
import 'package:app/features/auth/data/models/login_request_dto.dart';
import 'package:app/features/auth/data/models/login_response_dto.dart';
import 'package:app/features/auth/data/models/register_request_dto.dart';
import 'package:app/features/auth/data/models/user_response_dto.dart';
import 'package:app/features/task/data/models/create_task_request_dto.dart';
import 'package:app/features/task/data/models/task_response_dto.dart';
import 'package:app/features/task/data/models/update_task_request_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_endpoints.g.dart';

@RestApi()
abstract class ApiEndpoints {
  factory ApiEndpoints(Dio dio, {String? baseUrl}) = _ApiEndpoints;

  @POST('/api/v1/auth/register')
  Future<ApiResponse<void>> register(
    @Body() RegisterRequestDto body,
  );

  @POST('/api/v1/auth/login')
  Future<ApiResponse<LoginResponseDto>> login(
    @Body() LoginRequestDto credentials,
  );

  @GET('/api/v1/auth/me')
  Future<ApiResponse<UserResponseDto>> getProfile();

  @GET('/api/v1/tasks')
  Future<ApiResponse<List<TaskResponseDto>>> getTasks();

  @GET('/api/v1/tasks/{id}')
  Future<ApiResponse<TaskResponseDto>> getTask(
    @Path('id') int id,
  );

  @POST('/api/v1/tasks')
  Future<ApiResponse<TaskResponseDto>> createTask(
    @Body() CreateTaskRequestDto body,
  );

  @PATCH('/api/v1/tasks/{id}')
  Future<ApiResponse<TaskResponseDto>> updateTask(
    @Path('id') int id,
    @Body() UpdateTaskRequestDto body,
  );

  @DELETE('/api/v1/tasks/{id}')
  Future<ApiResponse<void>> deleteTask(
    @Path('id') int id,
  );
}

