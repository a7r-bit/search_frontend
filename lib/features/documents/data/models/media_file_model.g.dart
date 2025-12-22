// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaFileModel _$MediaFileModelFromJson(Map<String, dynamic> json) =>
    MediaFileModel(
      id: json['id'] as String,
      fileUrl: json['fileUrl'] as String,
      fileName: json['fileName'] as String,
      extention: json['extention'] as String,
      documentVersionId: json['documentVersionId'] as String,
    );

Map<String, dynamic> _$MediaFileModelToJson(MediaFileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fileUrl': instance.fileUrl,
      'fileName': instance.fileName,
      'extention': instance.extention,
      'documentVersionId': instance.documentVersionId,
    };
