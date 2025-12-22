// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticatedUserModel _$AuthenticatedUserModelFromJson(
  Map<String, dynamic> json,
) => AuthenticatedUserModel(
  user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
  tokens: TokensModel.fromJson(json['tokens'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthenticatedUserModelToJson(
  AuthenticatedUserModel instance,
) => <String, dynamic>{
  'user': instance.user.toJson(),
  'tokens': instance.tokens.toJson(),
};
