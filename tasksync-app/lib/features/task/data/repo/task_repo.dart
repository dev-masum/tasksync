import 'package:app/core/api/api_client.dart';
import 'package:app/core/utils/repo_guards.dart';
import 'package:app/features/task/data/models/create_task_request_dto.dart';
import 'package:app/features/task/data/models/update_task_request_dto.dart';
import 'package:app/features/task/domain/entities/task.dart';
import 'package:app/features/task/domain/repo/i_task_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ITaskRepository)
class TaskRepository with RepoGuard implements ITaskRepository {
  final ApiClient apiClient;

  TaskRepository({required this.apiClient});

  @override
  Future<List<Task>> getTasks() => guardApiCall(() async {
        final response = await apiClient.endpoints.getTasks();
        final dtos = response.data ?? [];
        return dtos.map((dto) => dto.toEntity()).toList();
      });

  @override
  Future<Task> getTaskById(int id) => guardApiCall(() async {
        final response = await apiClient.endpoints.getTask(id);
        return response.data!.toEntity();
      });

  @override
  Future<Task> createTask({
    required String title,
    required String description,
    required DateTime dueDate,
  }) =>
      guardApiCall(() async {
        final request = CreateTaskRequestDto(
          title: title,
          description: description,
          dueDate: dueDate,
        );
        final response = await apiClient.endpoints.createTask(request);
        return response.data!.toEntity();
      });

  @override
  Future<Task> updateTask({
    required int id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isComplete,
  }) =>
      guardApiCall(() async {
        final request = UpdateTaskRequestDto(
          title: title,
          description: description,
          dueDate: dueDate,
          isComplete: isComplete,
        );
        final response = await apiClient.endpoints.updateTask(id, request);
        return response.data!.toEntity();
      });

  @override
  Future<void> deleteTask(int id) => guardApiCall(() async {
        await apiClient.endpoints.deleteTask(id);
      });
}
