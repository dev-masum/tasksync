import 'package:app/core/error/failure.dart';
import 'package:app/core/result/result.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/repo/i_auth_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetProfileUseCase {
  final IAuthRepository _repo;

  GetProfileUseCase(this._repo);

  Future<Result<User>> call() async {
    try {
      final user = await _repo.getProfileRemote();
      return Success(user);
    } on Failure catch (e) {
      return FailureResult(e);
    }
  }
}
