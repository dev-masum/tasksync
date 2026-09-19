import 'package:app/core/error/failure.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/task/domain/entities/task.dart';
import 'package:app/features/task/domain/repo/i_task_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CreateTaskUseCase {
  final ITaskRepository _repository;

  CreateTaskUseCase(this._repository);

  Future<Result<Task>> call({
    required String title,
    required String description,
    required DateTime dueDate,
  }) async {
    try {
      final task = await _repository.createTask(
        title: title,
        description: description,
        dueDate: dueDate,
      );
      return Success(task);
    } on Failure catch (e) {
      return FailureResult(e);
    }
  }
}
