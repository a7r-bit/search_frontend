import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/features/documents/data/models/elastic_index_converter.dart';
import 'package:search_frontend/features/documents/data/models/node_type_convertor.dart';

import '../../../../core/domain/entities/node.dart';

part 'search_result.g.dart';

enum ElasticIndex { nodes, documentVersions }

@JsonSerializable()
class Highlight {
  final List<String>? name;
  final List<String>? description;
  final List<String>? fileName;
  final List<String>? content;

  Highlight(this.name, this.description, this.fileName, this.content);

  factory Highlight.fromJson(Map<String, dynamic> json) =>
      _$HighlightFromJson(json);

  Map<String, dynamic> toJson() => _$HighlightToJson(this);

  String? buildHighlight() {
    return name?.first ??
        description?.first ??
        fileName?.first ??
        content?.first;
  }
}

abstract class BaseSearchResultDTO {
  final String id;
  @ElasticIndexConverter()
  final ElasticIndex index;
  final double score;
  final Highlight? highlight;

  BaseSearchResultDTO({
    required this.id,
    required this.index,
    required this.score,
    this.highlight,
  });
}

@JsonSerializable()
class NodeSearchResultDTO extends BaseSearchResultDTO {
  @NodeTypeConvertor()
  final NodeType type;
  final String name;
  final String? description;

  NodeSearchResultDTO({
    required super.id,
    @ElasticIndexConverter() required super.index,
    required super.score,
    super.highlight,
    required this.type,
    required this.name,
    required this.description,
  });

  factory NodeSearchResultDTO.fromJson(Map<String, dynamic> json) =>
      _$NodeSearchResultDTOFromJson(json);

  Map<String, dynamic> toJson() => _$NodeSearchResultDTOToJson(this);
}

@JsonSerializable()
class DocumentVersionSearchResultDTO extends BaseSearchResultDTO {
  final int version;
  final String fileName;
  final String fileUrl;
  final DateTime createdAt;

  DocumentVersionSearchResultDTO({
    required super.id,
    @ElasticIndexConverter() required super.index,
    required super.score,
    super.highlight,
    required this.version,
    required this.fileName,
    required this.fileUrl,
    required this.createdAt,
  });

  factory DocumentVersionSearchResultDTO.fromJson(Map<String, dynamic> json) =>
      _$DocumentVersionSearchResultDTOFromJson(json);

  Map<String, dynamic> toJson() => _$DocumentVersionSearchResultDTOToJson(this);
}

typedef SearchResultDTO = BaseSearchResultDTO;

BaseSearchResultDTO searchResultFromJson(Map<String, dynamic> json) {
  final indexStr = json['index'] as String?;
  if (indexStr == null) {
    throw ArgumentError('index field is required in SearchResultDTO json');
  }

  final idx = const ElasticIndexConverter().fromJson(indexStr);

  switch (idx) {
    case ElasticIndex.nodes:
      return NodeSearchResultDTO.fromJson(json);
    case ElasticIndex.documentVersions:
      return DocumentVersionSearchResultDTO.fromJson(json);
  }
}

List<BaseSearchResultDTO> searchResultsFromJsonList(List<dynamic> list) {
  return list
      .map((e) => searchResultFromJson(e as Map<String, dynamic>))
      .toList();
}
