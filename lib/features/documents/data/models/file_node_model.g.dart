// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'node_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NodeModel _$FileNodeModelFromJson(Map<String, dynamic> json) => NodeModel(
  id: json['id'] as String,
  type: const NodeTypeConvertor().fromJson(json['type'] as String),
  name: json['name'] as String,
  description: json['description'] as String?,
  parentId: json['parentId'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$FileNodeModelToJson(NodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': const NodeTypeConvertor().toJson(instance.type),
      'name': instance.name,
      'description': instance.description,
      'parentId': instance.parentId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
