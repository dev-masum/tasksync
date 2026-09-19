import 'package:app/core/result/result.dart';
import 'package:app/features/task/domain/entities/task.dart';
import 'package:app/features/task/domain/usecases/get_task_by_id_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'task_detail_state.dart';

@injectable
class TaskDetailCubit extends Cubit<TaskDetailState> {
  final GetTaskByIdUseCase _getTaskByIdUseCase;

  TaskDetailCubit(this._getTaskByIdUseCase) : super(TaskDetailInitial());

  Future<void> fetchTask(int id) async {
    emit(TaskDetailLoading());
    final result = await _getTaskByIdUseCase(id);

    switch (result) {
      case Success(:final data):
        emit(TaskDetailLoaded(task: data));
      case FailureResult(:final failure):
        emit(TaskDetailFailure(message: failure.message));
    }
  }
}
