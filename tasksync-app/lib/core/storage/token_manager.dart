import 'package:injectable/injectable.dart';

import 'prefs.dart';

abstract interface class TokenManager {
  String? getToken();
  Future<bool> saveToken(String token);
  Future<bool> clearToken();
  bool hasToken();
}

@LazySingleton(as: TokenManager)
final class TokenManagerImpl implements TokenManager {
  final SharedPrefsStorage _storage;

  TokenManagerImpl(this._storage);

  @override
  String? getToken() => _storage.getString(tokenKey);

  @override
  Future<bool> saveToken(String token) async =>
      await _storage.setString(tokenKey, token);

  @override
  Future<bool> clearToken() async => await _storage.remove(tokenKey);

  @override
  bool hasToken() {
    final token = getToken();
    return token != null && token.isNotEmpty;
  }

  String get tokenKey => 'com.tasksync.app.accessToken';
}
