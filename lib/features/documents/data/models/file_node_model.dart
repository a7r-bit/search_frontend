import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
part 'file_node_model.g.dart';

@JsonSerializable()
class FileNodeModel {
  final String id;
  final String type;
  final String name;
  final String? description;
  final String? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  FileNodeModel({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileNodeModel.fromJson(Map<String, dynamic> json) =>
      _$FileNodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileNodeModelToJson(this);

  FileNode toDomain() => FileNode(
    id: id,
    type: type,
    name: name,
    description: description,
    parentId: parentId,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
