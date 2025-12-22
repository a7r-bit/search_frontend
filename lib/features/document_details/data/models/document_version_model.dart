import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/features/document_details/data/models/conversion_status_converter.dart';
import 'package:search_frontend/features/documents/data/models/media_file_model.dart';

part 'document_version_model.g.dart';

@JsonSerializable()
class DocumentVersionModel {
  final String id;
  final int version;
  final String documentId;
  @ConversionStatusConverter()
  final ConversionStatus conversionStatus;
  @JsonKey(name: 'mediaFile')
  final MediaFileModel? mediaFileModel;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory DocumentVersionModel.fromJson(Map<String, dynamic> json) =>
      _$DocumentVersionModelFromJson(json);

  const DocumentVersionModel({
    required this.id,
    required this.version,
    required this.documentId,
    required this.conversionStatus,
    required this.mediaFileModel,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => _$DocumentVersionModelToJson(this);

  DocumentVersion toDomain() => DocumentVersion(
    id: id,
    version: version,
    documentId: documentId,
    conversionStatus: conversionStatus,
    mediaFile: mediaFileModel?.toDomain(),
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
