part of 'task_action_cubit.dart';

sealed class TaskActionState extends Equatable {
  const TaskActionState();

  @override
  List<Object?> get props => [];
}

final class TaskActionInitial extends TaskActionState {}

final class TaskActionLoading extends TaskActionState {}

final class TaskActionSuccess extends TaskActionState {
  final Task task;

  const TaskActionSuccess(this.task);

  @override
  List<Object?> get props => [task];
}

final class TaskActionFailure extends TaskActionState {
  final String message;

  const TaskActionFailure(this.message);

  @override
  List<Object?> get props => [message];
}
