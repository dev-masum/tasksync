import 'package:app/core/value_object/value_object.dart';

class Password extends ValueObject<String> {
  @override
  final String value;

  const Password(this.value);

  factory Password.empty() => const Password('');

  static final _passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*()_+\-=\[\]{}|;:",./<>?]).{6,}$',
  );

  @override
  String? get errorMessage {
    if (value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    if (!_passwordRegex.hasMatch(value)) {
      return 'Must include uppercase, lowercase, number & special char';
    }
    return null;
  }
}
