import 'package:app/core/error/failure.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/task/domain/entities/task.dart';
import 'package:app/features/task/domain/repo/i_task_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateTaskUseCase {
  final ITaskRepository _repository;

  UpdateTaskUseCase(this._repository);

  Future<Result<Task>> call({
    required int id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isComplete,
  }) async {
    try {
      final task = await _repository.updateTask(
        id: id,
        title: title,
        description: description,
        dueDate: dueDate,
        isComplete: isComplete,
      );
      return Success(task);
    } on Failure catch (e) {
      return FailureResult(e);
    }
  }
}
