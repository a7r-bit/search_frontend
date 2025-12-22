import 'package:search_frontend/core/domain/entities/media_file.dart';

class DocumentVersion {
  final String id;
  final int version;
  final String documentId;
  final ConversionStatus conversionStatus;
  final MediaFile? mediaFile;
  final DateTime createdAt;
  final DateTime updatedAt;

  DocumentVersion({
    required this.id,
    required this.version,
    required this.documentId,
    required this.conversionStatus,
    required this.mediaFile,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'DocumentVersion('
        'id: $id, '
        'version: $version, '
        'documentId: $documentId, '
        'conversionStatus: $conversionStatus, '
        'mediaFile: ${mediaFile?.toString() ?? "null"}, '
        'createdAt: $createdAt, '
        'updatedAt: $updatedAt'
        ')';
  }
}

enum ConversionStatus { DONE, IN_PROGRESS, PENDING, FAILED }
