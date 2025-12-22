import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:search_frontend/core/constants/constants.dart';

class SecureStorage {
  final _storage = FlutterSecureStorage();

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storage.write(key: ACCESS_TOKEN_STORAGE_KEY, value: accessToken);
    await _storage.write(key: REFRESH_TOKEN_STORAGE_KEY, value: refreshToken);
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: ACCESS_TOKEN_STORAGE_KEY);
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: REFRESH_TOKEN_STORAGE_KEY);
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: ACCESS_TOKEN_STORAGE_KEY);
    await _storage.delete(key: REFRESH_TOKEN_STORAGE_KEY);
  }
}
