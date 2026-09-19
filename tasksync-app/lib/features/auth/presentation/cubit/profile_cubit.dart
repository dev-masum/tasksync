import 'package:app/core/result/result.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/usecases/get_profile_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase _getProfileUseCase;

  ProfileCubit(this._getProfileUseCase) : super(ProfileInitial());

  Future<void> fetchProfile() async {
    emit(ProfileLoading());
    final result = await _getProfileUseCase();

    switch (result) {
      case Success(:final data):
        emit(ProfileLoaded(user: data));
      case FailureResult(:final failure):
        emit(ProfileFailure(message: failure.message));
    }
  }
}
