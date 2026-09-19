import 'package:app/features/task/domain/entities/task.dart';

abstract interface class ITaskRepository {
  Future<List<Task>> getTasks();

  Future<Task> getTaskById(int id);

  Future<Task> createTask({
    required String title,
    required String description,
    required DateTime dueDate,
  });

  Future<Task> updateTask({
    required int id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isComplete,
  });

  Future<void> deleteTask(int id);
}
