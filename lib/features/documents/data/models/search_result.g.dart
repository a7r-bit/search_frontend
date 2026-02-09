// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Highlight _$HighlightFromJson(Map<String, dynamic> json) => Highlight(
  (json['name'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['description'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['fileName'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['content'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$HighlightToJson(Highlight instance) => <String, dynamic>{
  'name': instance.name,
  'description': instance.description,
  'fileName': instance.fileName,
  'content': instance.content,
};

NodeSearchResultDTO _$NodeSearchResultDTOFromJson(Map<String, dynamic> json) =>
    NodeSearchResultDTO(
      id: json['id'] as String,
      index: const ElasticIndexConverter().fromJson(json['index'] as String),
      score: (json['score'] as num).toDouble(),
      highlight: json['highlight'] == null
          ? null
          : Highlight.fromJson(json['highlight'] as Map<String, dynamic>),
      type: const NodeTypeConvertor().fromJson(json['type'] as String),
      name: json['name'] as String,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$NodeSearchResultDTOToJson(
  NodeSearchResultDTO instance,
) => <String, dynamic>{
  'id': instance.id,
  'index': const ElasticIndexConverter().toJson(instance.index),
  'score': instance.score,
  'highlight': instance.highlight,
  'type': const NodeTypeConvertor().toJson(instance.type),
  'name': instance.name,
  'description': instance.description,
};

DocumentVersionSearchResultDTO _$DocumentVersionSearchResultDTOFromJson(
  Map<String, dynamic> json,
) => DocumentVersionSearchResultDTO(
  id: json['id'] as String,
  index: const ElasticIndexConverter().fromJson(json['index'] as String),
  score: (json['score'] as num).toDouble(),
  highlight: json['highlight'] == null
      ? null
      : Highlight.fromJson(json['highlight'] as Map<String, dynamic>),
  version: (json['version'] as num).toInt(),
  fileName: json['fileName'] as String,
  fileUrl: json['fileUrl'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$DocumentVersionSearchResultDTOToJson(
  DocumentVersionSearchResultDTO instance,
) => <String, dynamic>{
  'id': instance.id,
  'index': const ElasticIndexConverter().toJson(instance.index),
  'score': instance.score,
  'highlight': instance.highlight,
  'version': instance.version,
  'fileName': instance.fileName,
  'fileUrl': instance.fileUrl,
  'createdAt': instance.createdAt.toIso8601String(),
};
