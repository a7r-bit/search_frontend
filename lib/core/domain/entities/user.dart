import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String uidNumber;
  final String firstName;
  final String middleName;
  final String activeRole;
  final List<String> roles;

  const User({
    required this.id,
    required this.uidNumber,
    required this.firstName,
    required this.middleName,
    required this.activeRole,
    required this.roles,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
