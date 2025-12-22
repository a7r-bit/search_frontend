// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_directory_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavedDirectoryModel _$SavedDirectoryModelFromJson(Map<String, dynamic> json) =>
    SavedDirectoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      childrenCount: (json['childrenCount'] as num).toInt(),
      documentCount: (json['documentCount'] as num).toInt(),
    );

Map<String, dynamic> _$SavedDirectoryModelToJson(
  SavedDirectoryModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'childrenCount': instance.childrenCount,
  'documentCount': instance.documentCount,
};
