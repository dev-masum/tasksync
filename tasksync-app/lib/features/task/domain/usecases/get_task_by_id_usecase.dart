import 'package:app/core/error/failure.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/task/domain/entities/task.dart';
import 'package:app/features/task/domain/repo/i_task_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetTaskByIdUseCase {
  final ITaskRepository _repository;

  GetTaskByIdUseCase(this._repository);

  Future<Result<Task>> call(int id) async {
    try {
      final task = await _repository.getTaskById(id);
      return Success(task);
    } on Failure catch (e) {
      return FailureResult(e);
    }
  }
}
