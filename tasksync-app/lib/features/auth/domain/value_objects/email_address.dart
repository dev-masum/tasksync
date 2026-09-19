import 'package:app/core/value_object/value_object.dart';

class EmailAddress extends ValueObject<String> {
  @override
  final String value;

  const EmailAddress(this.value);

  factory EmailAddress.empty() => const EmailAddress('');

  @override
  String? get errorMessage {
    if (value.trim().isEmpty) {
      return 'Email address is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }
}
