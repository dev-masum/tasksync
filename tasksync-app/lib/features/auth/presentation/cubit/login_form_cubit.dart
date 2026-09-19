import 'package:app/features/auth/domain/value_objects/email_address.dart';
import 'package:app/features/auth/domain/value_objects/password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_form_state.dart';

@injectable
class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(LoginFormState.initial());

  void emailChanged(String rawEmail) {
    emit(state.copyWith(email: EmailAddress(rawEmail)));
  }

  void passwordChanged(String rawPassword) {
    emit(state.copyWith(password: Password(rawPassword)));
  }

  bool validate() {
    emit(state.copyWith(showErrorMessages: true));
    return state.isValid;
  }
}
