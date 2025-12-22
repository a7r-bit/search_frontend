import '../../../../core/domain/entities/index.dart';

abstract class AuthRepository {
  Future<AuthenticatedUser> login(String username, String password);
  Future<AuthenticatedUser> switchRole(String requireRole);
}
