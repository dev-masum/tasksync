import 'package:app/core/result/result.dart';
import 'package:app/features/auth/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase _loginUseCase;

  LoginCubit(this._loginUseCase) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final result = await _loginUseCase(
      email: email,
      password: password,
    );

    switch (result) {
      case Success(:final data):
        emit(LoginSuccess(token: data));
      case FailureResult(:final failure):
        emit(LoginFailure(message: failure.message));
    }
  }
}
