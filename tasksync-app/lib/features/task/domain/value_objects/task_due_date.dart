import 'package:app/core/value_object/value_object.dart';

class TaskDueDate extends ValueObject<DateTime?> {
  @override
  final DateTime? value;

  const TaskDueDate(this.value);

  factory TaskDueDate.empty() => const TaskDueDate(null);

  @override
  String? get errorMessage {
    if (value == null) {
      return 'Due date is required';
    }
    return null;
  }
}
