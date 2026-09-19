import 'package:app/core/error/failure.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/auth/domain/repo/i_auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterUseCase {
  final IAuthRepository _repo;

  RegisterUseCase(this._repo);

  Future<Result<void>> call({
    required String fullname,
    required String email,
    required String password,
  }) async {
    try {
      await _repo.registerRemote(
        fullname: fullname,
        email: email,
        password: password,
      );
      return const Success(null);
    } on Failure catch (e) {
      return FailureResult(e);
    }
  }
}
