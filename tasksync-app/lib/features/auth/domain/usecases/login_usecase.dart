import 'package:app/core/error/failure.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/auth/domain/repo/i_auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginUseCase {
  final IAuthRepository _repo;

  LoginUseCase(this._repo);

  Future<Result<String>> call({
    required String email,
    required String password,
  }) async {
    try {
      final token = await _repo.loginRemote(
        email: email,
        password: password,
      );
      await _repo.saveToken(token);
      return Success(token);
    } on Failure catch (e) {
      return FailureResult(e);
    }
  }
}
