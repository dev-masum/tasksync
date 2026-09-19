import 'package:app/core/result/result.dart';
import 'package:app/features/task/domain/entities/task.dart';
import 'package:app/features/task/domain/usecases/create_task_usecase.dart';
import 'package:app/features/task/domain/usecases/update_task_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'task_action_state.dart';

@injectable
class TaskActionCubit extends Cubit<TaskActionState> {
  final CreateTaskUseCase _createTaskUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;

  TaskActionCubit(
    this._createTaskUseCase,
    this._updateTaskUseCase,
  ) : super(TaskActionInitial());

  Future<void> createTask({
    required String title,
    required String description,
    required DateTime dueDate,
  }) async {
    emit(TaskActionLoading());
    final result = await _createTaskUseCase(
      title: title,
      description: description,
      dueDate: dueDate,
    );

    switch (result) {
      case Success(:final data):
        emit(TaskActionSuccess(data));
      case FailureResult(:final failure):
        emit(TaskActionFailure(failure.message));
    }
  }

  Future<void> updateTask({
    required int id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isComplete,
  }) async {
    emit(TaskActionLoading());
    final result = await _updateTaskUseCase(
      id: id,
      title: title,
      description: description,
      dueDate: dueDate,
      isComplete: isComplete,
    );

    switch (result) {
      case Success(:final data):
        emit(TaskActionSuccess(data));
      case FailureResult(:final failure):
        emit(TaskActionFailure(failure.message));
    }
  }
}
