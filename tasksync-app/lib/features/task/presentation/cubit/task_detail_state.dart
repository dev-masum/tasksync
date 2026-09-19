part of 'task_detail_cubit.dart';

sealed class TaskDetailState extends Equatable {
  const TaskDetailState();

  @override
  List<Object?> get props => [];
}

final class TaskDetailInitial extends TaskDetailState {}

final class TaskDetailLoading extends TaskDetailState {}

final class TaskDetailLoaded extends TaskDetailState {
  final Task task;
  const TaskDetailLoaded({required this.task});

  @override
  List<Object?> get props => [task];
}

final class TaskDetailFailure extends TaskDetailState {
  final String message;
  const TaskDetailFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
