import 'package:app/features/auth/domain/value_objects/email_address.dart';
import 'package:app/features/auth/domain/value_objects/full_name.dart';
import 'package:app/features/auth/domain/value_objects/password.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'register_form_state.dart';

@injectable
class RegisterFormCubit extends Cubit<RegisterFormState> {
  RegisterFormCubit() : super(RegisterFormState.initial());

  void fullNameChanged(String rawName) {
    emit(state.copyWith(fullName: FullName(rawName)));
  }

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
