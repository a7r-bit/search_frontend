import 'package:dio/dio.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/document_details/data/models/document_version_model.dart';

abstract class DocumentVersionRemoteDataSource {
  Future<DocumentVersionModel> getDocumentVersionById({
    required String docVersionId,
  });
  Future<List<DocumentVersionModel>> getDocumentVersionsByDocumentId({
    required String documentId,
    String? fileName,
    ConversionStatus? conversionStatus,
    String? sortParam,
  });

  Future<DocumentVersionModel> createDocumentVersion({
    required String documentId,
    required MultipartFile multipartFile,
    Function(int sent, int total)? onProgress,
  });

  Future<DocumentVersionModel> updateDocumentVersion({
    required String documentVersionId,
    required int verion,
    required String fileName,
  });
  Future<DocumentVersionModel> deleteDocumentVersionById({
    required String documentVersionId,
  });
}

class DocumentVersionRemoteDataSourceImpl
    implements DocumentVersionRemoteDataSource {
  final ApiClient _apiClient;

  DocumentVersionRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<DocumentVersionModel> getDocumentVersionById({
    required String docVersionId,
  }) async {
    final Map<String, dynamic> responce = await _apiClient.get(
      "/document-versions/$docVersionId",
    );
    return DocumentVersionModel.fromJson(responce);
  }

  @override
  Future<List<DocumentVersionModel>> getDocumentVersionsByDocumentId({
    required String documentId,
    String? fileName,
    ConversionStatus? conversionStatus,
    String? sortParam,
  }) async {
    final responce = await _apiClient.get(
      "/document-versions/$documentId/document",
      queryParams: {
        if (fileName != null) 'fileName': fileName,
        if (conversionStatus != null) 'conversionStatus': conversionStatus.name,
        if (sortParam != null) 'sort': sortParam,
      },
    );
    final List<dynamic> data = responce;
    return data
        .map((e) => DocumentVersionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<DocumentVersionModel> createDocumentVersion({
    required String documentId,
    required MultipartFile multipartFile,
    Function(int sent, int total)? onProgress,
  }) async {
    final formData = FormData.fromMap({
      "documentId": documentId,
      "file": multipartFile,
    });
    final Map<String, dynamic> response = await _apiClient.post(
      "/document-versions/",
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
      onSendProgress: (sent, total) {
        if (onProgress != null) {
          onProgress(sent, total);
        }
      },
    );
    return DocumentVersionModel.fromJson(response);
  }

  @override
  Future<DocumentVersionModel> updateDocumentVersion({
    required String documentVersionId,
    required int verion,
    required String fileName,
  }) async {
    final Map<String, dynamic> responce = await _apiClient.patch(
      "/document-versions/$documentVersionId",
      data: {"version": verion, "fileName": fileName},
    );
    return DocumentVersionModel.fromJson(responce);
  }

  @override
  Future<DocumentVersionModel> deleteDocumentVersionById({
    required String documentVersionId,
  }) async {
    final Map<String, dynamic> responce = await _apiClient.delete(
      "/document-versions/$documentVersionId",
    );
    return DocumentVersionModel.fromJson(responce);
  }
}
