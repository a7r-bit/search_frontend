import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/auth/data/models/authenticated_user_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthenticatedUserModel> login(String username, String password);
  Future<AuthenticatedUserModel> switchRole(String requireRole);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;

  AuthRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<AuthenticatedUserModel> login(String username, String password) async {
    print("Login request: username=$username, password=$password");
    final response = await _apiClient.post(
      '/auth/signIn',
      data: {"username": username, "password": password},
    );
    print("Login response: $response");

    final model = AuthenticatedUserModel.fromJson(response);
    print("Parsed AuthenticatedUserModel: $model");
    return model;
  }

  @override
  Future<AuthenticatedUserModel> switchRole(String requireRole) async {
    final response = await _apiClient.post(
      '/auth/switch-role',
      data: {"requireRole": requireRole},
    );

    return AuthenticatedUserModel.fromJson(response);
  }
}
