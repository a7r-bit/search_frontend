import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
part 'media_file_model.g.dart';

@JsonSerializable()
class MediaFileModel {
  final String id;
  final String fileUrl;
  final String fileName;
  final String extention;
  final String documentVersionId;

  MediaFileModel({
    required this.id,
    required this.fileUrl,
    required this.fileName,
    required this.extention,
    required this.documentVersionId,
  });

  factory MediaFileModel.fromJson(Map<String, dynamic> json) =>
      _$MediaFileModelFromJson(json);

  Map<String, dynamic> toJson() => _$MediaFileModelToJson(this);
  MediaFile toDomain() => MediaFile(
    id: id,
    fileUrl: fileUrl,
    fileName: fileName,
    extention: extention,
    documentVersionId: documentVersionId,
  );
}
