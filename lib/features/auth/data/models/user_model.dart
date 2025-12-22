import 'package:json_annotation/json_annotation.dart';

import '../../../../core/domain/entities/index.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.uidNumber,
    required super.firstName,
    required super.middleName,
    required super.activeRole,
    required super.roles,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  User toDomain() => User(
    id: id,
    uidNumber: uidNumber,
    firstName: firstName,
    middleName: middleName,
    activeRole: activeRole,
    roles: roles,
  );

  @override
  String toString() {
    return 'UserModel(id: $id, uidNumber: $uidNumber, firstName: $firstName, middleName: $middleName, activeRole: $activeRole, roles: $roles)';
  }
}
