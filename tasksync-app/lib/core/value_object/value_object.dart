import 'package:equatable/equatable.dart';

abstract class ValueObject<T> extends Equatable {
  const ValueObject();

  T get value;
  String? get errorMessage;

  bool get isValid => errorMessage == null;

  @override
  List<Object?> get props => [value, errorMessage];
}
