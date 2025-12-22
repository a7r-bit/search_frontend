// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  uidNumber: json['uidNumber'] as String,
  firstName: json['firstName'] as String,
  middleName: json['middleName'] as String,
  activeRole: json['activeRole'] as String,
  roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'uidNumber': instance.uidNumber,
  'firstName': instance.firstName,
  'middleName': instance.middleName,
  'activeRole': instance.activeRole,
  'roles': instance.roles,
};
