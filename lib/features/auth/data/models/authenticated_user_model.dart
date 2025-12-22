import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'user_model.dart';
import 'tokens_model.dart';

part 'authenticated_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AuthenticatedUserModel {
  final UserModel user;
  final TokensModel tokens;

  const AuthenticatedUserModel({required this.user, required this.tokens});

  factory AuthenticatedUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticatedUserModelToJson(this);

  AuthenticatedUser toDomain() => AuthenticatedUser(user: user.toDomain());

  @override
  String toString() {
    return 'AuthenticatedUserModel(user: $user, tokens: $tokens)';
  }
}
