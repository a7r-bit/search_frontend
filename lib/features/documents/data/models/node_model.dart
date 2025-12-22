import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/features/documents/data/models/node_type_convertor.dart';
part 'file_node_model.g.dart';

@JsonSerializable()
class NodeModel {
  final String id;
  @NodeTypeConvertor()
  final NodeType type;
  final String name;
  final String? description;
  final String? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  NodeModel({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NodeModel.fromJson(Map<String, dynamic> json) =>
      _$FileNodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$FileNodeModelToJson(this);

  Node toDomain() => Node(
    id: id,
    type: type,
    name: name,
    description: description,
    parentId: parentId,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
