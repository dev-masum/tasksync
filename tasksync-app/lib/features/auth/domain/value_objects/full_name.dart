import 'package:app/core/value_object/value_object.dart';

class FullName extends ValueObject<String> {
  @override
  final String value;

  const FullName(this.value);

  factory FullName.empty() => const FullName('');

  @override
  String? get errorMessage {
    if (value.trim().isEmpty) {
      return 'Full name is required';
    }
    return null;
  }
}
