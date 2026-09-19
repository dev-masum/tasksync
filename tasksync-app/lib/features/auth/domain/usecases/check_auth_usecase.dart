import 'package:app/core/error/failure.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/auth/domain/repo/i_auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class CheckAuthUseCase {
  final IAuthRepository _repo;

  CheckAuthUseCase(this._repo);

  Future<Result<bool>> call() async {
    try {
      final loggedIn = await _repo.isLoggedIn();
      return Success(loggedIn);
    } on Failure catch (e) {
      return FailureResult(e);
    }
  }
}
