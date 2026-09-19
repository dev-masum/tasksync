import 'package:app/features/auth/domain/entities/user.dart';

abstract interface class IAuthRepository {
  Future<void> registerRemote({
    required String fullname,
    required String email,
    required String password,
  });

  Future<String> loginRemote({
    required String email,
    required String password,
  });

  Future<User> getProfileRemote();

  Future<void> saveToken(String token);

  Future<void> clearToken();

  Future<bool> isLoggedIn();
}
