import 'package:app/core/error/failure.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/task/domain/repo/i_task_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteTaskUseCase {
  final ITaskRepository _repository;

  DeleteTaskUseCase(this._repository);

  Future<Result<void>> call(int id) async {
    try {
      await _repository.deleteTask(id);
      return const Success(null);
    } on Failure catch (e) {
      return FailureResult(e);
    }
  }
}
