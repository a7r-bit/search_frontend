import 'package:search_frontend/core/constants/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SecureStorage {
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ACCESS_TOKEN_STORAGE_KEY, accessToken);
    await prefs.setString(REFRESH_TOKEN_STORAGE_KEY, refreshToken);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(ACCESS_TOKEN_STORAGE_KEY);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(REFRESH_TOKEN_STORAGE_KEY);
  }

  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(ACCESS_TOKEN_STORAGE_KEY);
    await prefs.remove(REFRESH_TOKEN_STORAGE_KEY);
  }
}
