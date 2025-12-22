import 'package:dio/dio.dart';
import 'package:search_frontend/core/domain/entities/index.dart';

abstract class DocumentVersionRepository {
  Future<DocumentVersion> getDocumentVersionById({
    required String docVersionId,
  });
  Future<List<DocumentVersion>> getDocumentVersionsByDocumentId({
    required String documentId,
    String? fileName,
    ConversionStatus? conversionStatus,
    String? sortParam,
    String? sortOrder,
  });

  Future<DocumentVersion> createDocumentVersion({
    required String documentId,
    required MultipartFile multipartFile,
    Function(int sent, int total)? onProgress,
  });

  Future<DocumentVersion> updateDocumentVersion({
    required String documentVersionId,
    required int verion,
    required String fileName,
  });
  Future<DocumentVersion> deleteDocumentVersionById({
    required String documentVersionId,
  });
}
