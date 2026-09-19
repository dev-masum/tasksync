import 'package:app/core/value_object/value_object.dart';

class TaskDescription extends ValueObject<String> {
  @override
  final String value;

  const TaskDescription(this.value);

  factory TaskDescription.empty() => const TaskDescription('');

  @override
  String? get errorMessage {
    if (value.trim().isEmpty) {
      return 'Description is required';
    }
    if (value.trim().length > 1000) {
      return 'Description must be at most 1000 characters';
    }
    return null;
  }
}
