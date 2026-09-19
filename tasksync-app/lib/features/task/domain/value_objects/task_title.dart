import 'package:app/core/value_object/value_object.dart';

class TaskTitle extends ValueObject<String> {
  @override
  final String value;

  const TaskTitle(this.value);

  factory TaskTitle.empty() => const TaskTitle('');

  @override
  String? get errorMessage {
    if (value.trim().isEmpty) {
      return 'Title is required';
    }
    if (value.trim().length > 255) {
      return 'Title must be at most 255 characters';
    }
    return null;
  }
}
