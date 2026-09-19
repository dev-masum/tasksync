import 'package:app/features/task/domain/value_objects/task_description.dart';
import 'package:app/features/task/domain/value_objects/task_due_date.dart';
import 'package:app/features/task/domain/value_objects/task_title.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'task_form_state.dart';

@injectable
class TaskFormCubit extends Cubit<TaskFormState> {
  TaskFormCubit() : super(TaskFormState.initial());

  void initForm({
    String? title,
    String? description,
    DateTime? dueDate,
  }) {
    emit(TaskFormState(
      title: TaskTitle(title ?? ''),
      description: TaskDescription(description ?? ''),
      dueDate: TaskDueDate(dueDate),
      showErrorMessages: false,
    ));
  }

  void titleChanged(String rawTitle) {
    emit(state.copyWith(title: TaskTitle(rawTitle)));
  }

  void descriptionChanged(String rawDescription) {
    emit(state.copyWith(description: TaskDescription(rawDescription)));
  }

  void dueDateChanged(DateTime? date) {
    emit(state.copyWith(dueDate: TaskDueDate(date)));
  }

  bool validate() {
    emit(state.copyWith(showErrorMessages: true));
    return state.isValid;
  }
}
