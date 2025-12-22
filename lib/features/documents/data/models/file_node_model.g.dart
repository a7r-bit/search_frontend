// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_node_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileNodeModel _$FileNodeModelFromJson(Map<String, dynamic> json) =>
    FileNodeModel(
      id: json['id'] as String,
      type: json['type'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      parentId: json['parentId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$FileNodeModelToJson(FileNodeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'description': instance.description,
      'parentId': instance.parentId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
