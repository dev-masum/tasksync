part of 'login_form_cubit.dart';

class LoginFormState extends Equatable {
  final EmailAddress email;
  final Password password;
  final bool showErrorMessages;

  const LoginFormState({
    required this.email,
    required this.password,
    required this.showErrorMessages,
  });

  factory LoginFormState.initial() => LoginFormState(
        email: EmailAddress.empty(),
        password: Password.empty(),
        showErrorMessages: false,
      );

  bool get isValid => email.isValid && password.isValid;

  LoginFormState copyWith({
    EmailAddress? email,
    Password? password,
    bool? showErrorMessages,
  }) {
    return LoginFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
    );
  }

  @override
  List<Object?> get props => [email, password, showErrorMessages];
}
