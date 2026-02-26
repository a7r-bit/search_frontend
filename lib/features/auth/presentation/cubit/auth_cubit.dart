import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/auth/data/models/authenticated_user_model.dart';
import 'package:search_frontend/features/auth/presentation/cubit/auth_state.dart';
import '../../../../core/domain/entities/index.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../../../core/domain/entities/authenticated_user.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  final AuthRepository repository;

  AuthCubit({required this.repository}) : super(const AuthState());

  Future<void> login(String username, String password) async {
    emit(state.copyWith(status: AuthStatus.loading));
    final previousState = state;
    try {
      final AuthenticatedUser authUser = await repository.login(
        username,
        password,
      );
      emit(
        state.copyWith(
          status: AuthStatus.success,
          message: "Успешный вход",
          user: authUser.user,
        ),
      );
    } on Failure catch (e) {
      addError(e);
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: e.message,
          errorCode: "${e.code}",
        ),
      );
    }
  }

  Future<void> switchRole(String requiredRole) async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final AuthenticatedUser authUser = await repository.switchRole(
        requiredRole,
      );
      emit(
        state.copyWith(
          status: AuthStatus.success,
          message: "Успешный вход",
          user: authUser.user,
        ),
      );
    } on Failure catch (e) {
      addError(e);
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          message: e.message,
          errorCode: "${e.code}",
        ),
      );
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
