import 'package:search_frontend/core/errors/error_mapper.dart';
import 'package:search_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:search_frontend/features/auth/domain/repositories/auth_repository.dart';

import '../../../core/domain/entities/index.dart';
import '../../../core/utils/index.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final SecureStorage secureStorage;
  final ApiClient apiClient;
  const AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.secureStorage,
    required this.apiClient,
  });

  @override
  Future<AuthenticatedUser> login(String username, String password) async {
    try {
      final model = await remoteDataSource.login(username, password);

      await secureStorage.saveTokens(
        accessToken: model.tokens.accessToken,
        refreshToken: model.tokens.refreshToken,
      );
      apiClient.setToken(model.tokens.accessToken);

      return model.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<AuthenticatedUser> switchRole(String requireRole) async {
    try {
      final model = await remoteDataSource.switchRole(requireRole);

      await secureStorage.saveTokens(
        accessToken: model.tokens.accessToken,
        refreshToken: model.tokens.refreshToken,
      );
      apiClient.setToken(model.tokens.accessToken);

      return model.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
