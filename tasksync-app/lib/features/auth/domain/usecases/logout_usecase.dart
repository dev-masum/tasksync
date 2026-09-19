import 'package:app/core/error/failure.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/auth/domain/repo/i_auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class LogoutUseCase {
  final IAuthRepository _repo;

  LogoutUseCase(this._repo);

  Future<Result<void>> call() async {
    try {
      await _repo.clearToken();
      return const Success(null);
    } on Failure catch (e) {
      return FailureResult(e);
    }
  }
}
