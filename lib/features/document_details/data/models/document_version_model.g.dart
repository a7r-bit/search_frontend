// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentVersionModel _$DocumentVersionModelFromJson(
  Map<String, dynamic> json,
) => DocumentVersionModel(
  id: json['id'] as String,
  version: (json['version'] as num).toInt(),
  nodeId: json['nodeId'] as String,
  conversionStatus: const ConversionStatusConverter().fromJson(
    json['conversionStatus'] as String,
  ),
  mediaFileModel: json['mediaFile'] == null
      ? null
      : MediaFileModel.fromJson(json['mediaFile'] as Map<String, dynamic>),
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);

Map<String, dynamic> _$DocumentVersionModelToJson(
  DocumentVersionModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'version': instance.version,
  'nodeId': instance.nodeId,
  'conversionStatus': const ConversionStatusConverter().toJson(
    instance.conversionStatus,
  ),
  'mediaFile': instance.mediaFileModel,
  'createdAt': instance.createdAt.toIso8601String(),
  'updatedAt': instance.updatedAt.toIso8601String(),
};
