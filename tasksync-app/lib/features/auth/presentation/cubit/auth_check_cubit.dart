import 'package:app/core/result/result.dart';
import 'package:app/features/auth/domain/usecases/check_auth_usecase.dart';
import 'package:app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_check_state.dart';

@injectable
class AuthCheckCubit extends Cubit<AuthCheckState> {
  final CheckAuthUseCase _checkAuthUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthCheckCubit(
    this._checkAuthUseCase,
    this._logoutUseCase,
  ) : super(AuthCheckInitial());

  Future<void> checkAuth() async {
    emit(AuthCheckLoading());
    final result = await _checkAuthUseCase();

    switch (result) {
      case Success(:final data):
        if (data) {
          emit(AuthCheckAuthenticated());
        } else {
          emit(AuthCheckUnauthenticated());
        }
      case FailureResult():
        emit(AuthCheckUnauthenticated());
    }
  }

  Future<void> logout() async {
    emit(AuthCheckLoading());
    final result = await _logoutUseCase();

    switch (result) {
      case Success():
        emit(AuthCheckUnauthenticated());
      case FailureResult(:final failure):
        emit(AuthCheckFailure(message: failure.message));
    }
  }
}


