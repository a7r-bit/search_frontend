import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';

class NodeTypeConvertor extends JsonConverter<NodeType, String> {
  const NodeTypeConvertor();

  @override
  NodeType fromJson(String json) {
    switch (json) {
      case "DIRECTORY":
        return NodeType.DIRECTORY;
      case "DOCUMENT":
        return NodeType.DOCUMENT;
      default:
        throw Failure("NodeTypeConvertor error");
    }
  }

  @override
  String toJson(NodeType type) => type.name;
}
