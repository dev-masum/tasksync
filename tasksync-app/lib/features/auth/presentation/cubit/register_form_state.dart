part of 'register_form_cubit.dart';

class RegisterFormState extends Equatable {
  final FullName fullName;
  final EmailAddress email;
  final Password password;
  final bool showErrorMessages;

  const RegisterFormState({
    required this.fullName,
    required this.email,
    required this.password,
    required this.showErrorMessages,
  });

  factory RegisterFormState.initial() => RegisterFormState(
        fullName: FullName.empty(),
        email: EmailAddress.empty(),
        password: Password.empty(),
        showErrorMessages: false,
      );

  bool get isValid => fullName.isValid && email.isValid && password.isValid;

  RegisterFormState copyWith({
    FullName? fullName,
    EmailAddress? email,
    Password? password,
    bool? showErrorMessages,
  }) {
    return RegisterFormState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
    );
  }

  @override
  List<Object?> get props => [fullName, email, password, showErrorMessages];
}
