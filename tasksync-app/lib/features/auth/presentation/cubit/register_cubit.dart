import 'package:app/core/result/result.dart';
import 'package:app/features/auth/domain/usecases/register_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase _registerUseCase;

  RegisterCubit(this._registerUseCase) : super(RegisterInitial());

  Future<void> register({
    required String fullname,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    final result = await _registerUseCase(
      fullname: fullname,
      email: email,
      password: password,
    );

    switch (result) {
      case Success():
        emit(RegisterSuccess());
      case FailureResult(:final failure):
        emit(RegisterFailure(message: failure.message));
    }
  }
}
