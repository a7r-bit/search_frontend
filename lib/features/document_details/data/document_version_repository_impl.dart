import 'package:dio/src/multipart_file.dart';
import 'package:search_frontend/core/domain/entities/document_version.dart';
import 'package:search_frontend/core/errors/error_mapper.dart';
import 'package:search_frontend/features/document_details/data/datasources/document_version_remote_data_source.dart';
import 'package:search_frontend/features/document_details/data/models/document_version_model.dart';
import 'package:search_frontend/features/document_details/domain/repositories/document_version_repository.dart';

class DocumentVersionRepositoryImpl implements DocumentVersionRepository {
  final DocumentVersionRemoteDataSource remoteDataSource;

  DocumentVersionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DocumentVersion> getDocumentVersionById({
    required String docVersionId,
  }) async {
    try {
      final documentVersion = await remoteDataSource.getDocumentVersionById(
        docVersionId: docVersionId,
      );
      return documentVersion.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<List<DocumentVersion>> getDocumentVersionsByNodeId({
    required String nodeId,
    String? fileName,
    ConversionStatus? conversionStatus,
    String? sortParam,
    String? sortOrder = "asc",
  }) async {
    try {
      final documentVersions = await remoteDataSource
          .getDocumentVersionsByNodeId(
            nodeId: nodeId,
            fileName: fileName,
            conversionStatus: conversionStatus,
            sortParam: (sortParam != null && sortOrder != null)
                ? '$sortParam:$sortOrder'
                : null,
          );

      return documentVersions.map((e) => e.toDomain()).toList();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<DocumentVersion> createDocumentVersion({
    required String nodeId,
    required MultipartFile multipartFile,
    Function(int sent, int total)? onProgress,
  }) async {
    try {
      final documentVersion = await remoteDataSource.createDocumentVersion(
        nodeId: nodeId,
        multipartFile: multipartFile,
        onProgress: onProgress,
      );

      return documentVersion.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<DocumentVersion> updateDocumentVersion({
    required String documentVersionId,
    required int verion,
    required String fileName,
  }) async {
    try {
      final documentVersion = await remoteDataSource.updateDocumentVersion(
        documentVersionId: documentVersionId,
        verion: verion,
        fileName: fileName,
      );
      return documentVersion.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<DocumentVersion> deleteDocumentVersionById({
    required String documentVersionId,
  }) async {
    try {
      final DocumentVersionModel documentVersion = await remoteDataSource
          .deleteDocumentVersionById(documentVersionId: documentVersionId);
      return documentVersion.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
