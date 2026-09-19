part of 'task_form_cubit.dart';

class TaskFormState extends Equatable {
  final TaskTitle title;
  final TaskDescription description;
  final TaskDueDate dueDate;
  final bool showErrorMessages;

  const TaskFormState({
    required this.title,
    required this.description,
    required this.dueDate,
    required this.showErrorMessages,
  });

  factory TaskFormState.initial() => TaskFormState(
        title: TaskTitle.empty(),
        description: TaskDescription.empty(),
        dueDate: TaskDueDate.empty(),
        showErrorMessages: false,
      );

  bool get isValid => title.isValid && description.isValid && dueDate.isValid;

  TaskFormState copyWith({
    TaskTitle? title,
    TaskDescription? description,
    TaskDueDate? dueDate,
    bool? showErrorMessages,
  }) {
    return TaskFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
    );
  }

  @override
  List<Object?> get props => [title, description, dueDate, showErrorMessages];
}
