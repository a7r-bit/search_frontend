import 'package:json_annotation/json_annotation.dart';

import '../../../../core/domain/entities/index.dart';

part 'auth_state.g.dart';

enum AuthStatus { initial, loading, success, failure }

@JsonSerializable(explicitToJson: true)
class AuthState {
  final AuthStatus status;
  final User? user;
  final String? message;
  final String? errorCode;

  const AuthState({
    this.status = AuthStatus.initial,
    this.user,
    this.message,
    this.errorCode,
  });

  AuthState copyWith({
    AuthStatus? status,
    User? user,
    String? message,
    String? errorCode,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      message: message ?? this.message,
      errorCode: errorCode ?? this.errorCode,
    );
  }

  @override
  String toString() {
    return 'AuthState(status: $status, '
        'user: $user, '
        'message: $message, '
        'errorCode: $errorCode)';
  }

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);

  Map<String, dynamic> toJson() => _$AuthStateToJson(this);
}
