import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';

part 'path_part_model.g.dart';

@JsonSerializable()
class PathPartModel {
  final String? id;
  final String name;

  PathPartModel({required this.id, required this.name});

  factory PathPartModel.fromJson(Map<String, dynamic> json) =>
      _$PathPartModelFromJson(json);

  Map<String, dynamic> toJson() => _$PathPartModelToJson(this);

  PathPart toDomain() => PathPart(id: id, name: name);
}
