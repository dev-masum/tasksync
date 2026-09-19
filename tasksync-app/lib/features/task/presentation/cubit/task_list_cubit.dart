import 'package:app/core/result/result.dart';
import 'package:app/features/task/domain/entities/task.dart';
import 'package:app/features/task/domain/usecases/delete_task_usecase.dart';
import 'package:app/features/task/domain/usecases/get_tasks_usecase.dart';
import 'package:app/features/task/domain/usecases/update_task_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'task_list_state.dart';

@injectable
class TaskListCubit extends Cubit<TaskListState> {
  final GetTasksUseCase _getTasksUseCase;
  final UpdateTaskUseCase _updateTaskUseCase;
  final DeleteTaskUseCase _deleteTaskUseCase;

  TaskListCubit(
    this._getTasksUseCase,
    this._updateTaskUseCase,
    this._deleteTaskUseCase,
  ) : super(TaskListInitial());

  Future<void> fetchTasks() async {
    emit(TaskListLoading());
    final result = await _getTasksUseCase();

    switch (result) {
      case Success(:final data):
        emit(TaskListLoaded(allTasks: data));
      case FailureResult(:final failure):
        emit(TaskListError(failure.message));
    }
  }

  void filterChanged(TaskFilter filter) {
    if (state is TaskListLoaded) {
      final loaded = state as TaskListLoaded;
      emit(loaded.copyWith(filter: filter));
    }
  }

  Future<void> toggleTaskComplete(int id, bool isComplete) async {
    if (state is! TaskListLoaded) return;
    final currentState = state as TaskListLoaded;

    final updatedTasks = currentState.allTasks.map((t) {
      if (t.id == id) {
        return t.copyWith(isComplete: isComplete);
      }
      return t;
    }).toList();
    emit(currentState.copyWith(allTasks: updatedTasks));

    final result = await _updateTaskUseCase(id: id, isComplete: isComplete);
    if (result is FailureResult) {
      fetchTasks();
    }
  }

  Future<void> deleteTask(int id) async {
    if (state is! TaskListLoaded) return;
    final currentState = state as TaskListLoaded;

    final updatedTasks = currentState.allTasks.where((t) => t.id != id).toList();
    emit(currentState.copyWith(allTasks: updatedTasks));

    final result = await _deleteTaskUseCase(id);
    if (result is FailureResult) {
      fetchTasks();
    }
  }
}
