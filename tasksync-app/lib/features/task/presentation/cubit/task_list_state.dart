part of 'task_list_cubit.dart';

enum TaskFilter { all, active, completed }

sealed class TaskListState extends Equatable {
  const TaskListState();

  @override
  List<Object?> get props => [];
}

final class TaskListInitial extends TaskListState {}

final class TaskListLoading extends TaskListState {}

final class TaskListLoaded extends TaskListState {
  final List<Task> allTasks;
  final TaskFilter filter;

  const TaskListLoaded({
    required this.allTasks,
    this.filter = TaskFilter.all,
  });

  List<Task> get filteredTasks {
    switch (filter) {
      case TaskFilter.all:
        return allTasks;
      case TaskFilter.active:
        return allTasks.where((task) => !task.isComplete).toList();
      case TaskFilter.completed:
        return allTasks.where((task) => task.isComplete).toList();
    }
  }

  TaskListLoaded copyWith({
    List<Task>? allTasks,
    TaskFilter? filter,
  }) {
    return TaskListLoaded(
      allTasks: allTasks ?? this.allTasks,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object?> get props => [allTasks, filter];
}

final class TaskListError extends TaskListState {
  final String message;

  const TaskListError(this.message);

  @override
  List<Object?> get props => [message];
}
