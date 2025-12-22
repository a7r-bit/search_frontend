import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/document_details/data/models/document_model.dart';

abstract class DocumentRemoteDataSource {
  Future<DocumentModel> getDocumentById({required String id});
}

class DocumentRemoteDataSourceImpl implements DocumentRemoteDataSource {
  final ApiClient _apiClient;

  DocumentRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;
  @override
  Future<DocumentModel> getDocumentById({required String id}) async {
    final Map<String, dynamic> responce = await _apiClient.get(
      "/documents/$id",
    );
    return DocumentModel.fromJson(responce);
  }
}
