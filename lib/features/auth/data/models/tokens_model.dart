import 'package:json_annotation/json_annotation.dart';
import '../../../../core/domain/entities/index.dart';
part 'tokens_model.g.dart';

@JsonSerializable()
class TokensModel extends Tokens {
  @override
  @JsonKey(name: "access_token")
  final String accessToken;

  @override
  @JsonKey(name: "refresh_token")
  final String refreshToken;

  const TokensModel({required this.accessToken, required this.refreshToken})
    : super(accessToken: accessToken, refreshToken: refreshToken);

  factory TokensModel.fromJson(Map<String, dynamic> json) =>
      _$TokensModelFromJson(json);

  Map<String, dynamic> toJson() => _$TokensModelToJson(this);

  Tokens toDomain() =>
      Tokens(accessToken: accessToken, refreshToken: refreshToken);

  @override
  String toString() {
    return 'TokensModel(accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}
