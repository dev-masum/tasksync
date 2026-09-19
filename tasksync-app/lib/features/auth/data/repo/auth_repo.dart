import 'package:app/core/api/api_client.dart';
import 'package:app/core/storage/token_manager.dart';
import 'package:app/core/utils/repo_guards.dart';
import 'package:app/features/auth/data/models/login_request_dto.dart';
import 'package:app/features/auth/data/models/register_request_dto.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/repo/i_auth_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository with RepoGuard implements IAuthRepository {
  final ApiClient apiClient;
  final TokenManager tokenManager;

  AuthRepository({required this.apiClient, required this.tokenManager});

  @override
  Future<void> registerRemote({
    required String fullname,
    required String email,
    required String password,
  }) =>
      guardApiCall(() async {
        await apiClient.endpoints.register(
          RegisterRequestDto(
            fullname: fullname,
            email: email,
            password: password,
          ),
        );
      });

  @override
  Future<String> loginRemote({
    required String email,
    required String password,
  }) =>
      guardApiCall(() async {
        final response = await apiClient.endpoints.login(
          LoginRequestDto(email: email, password: password),
        );

        return response.data!.accessToken;
      });

  @override
  Future<User> getProfileRemote() => guardApiCall(() async {
        final response = await apiClient.endpoints.getProfile();
        final data = response.data!;

        return User(
          id: data.id,
          fullname: data.fullname,
          email: data.email,
          createdAt: data.createdAt,
        );
      });

  @override
  Future<void> saveToken(String token) => guardLocalCall(() async {
        await tokenManager.saveToken(token);
      });

  @override
  Future<void> clearToken() => guardLocalCall(() async {
        await tokenManager.clearToken();
      });

  @override
  Future<bool> isLoggedIn() => guardLocalCall(() async {
        return tokenManager.hasToken();
      });
}

