import 'package:app/core/error/failure.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/task/domain/entities/task.dart';
import 'package:app/features/task/domain/repo/i_task_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTasksUseCase {
  final ITaskRepository _repository;

  GetTasksUseCase(this._repository);

  Future<Result<List<Task>>> call() async {
    try {
      final tasks = await _repository.getTasks();
      return Success(tasks);
    } on Failure catch (e) {
      return FailureResult(e);
    }
  }
}
