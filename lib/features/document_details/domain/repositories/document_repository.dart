import 'package:search_frontend/core/domain/entities/index.dart';

abstract class DocumentRepository {
  Future<Document> getDocumentById({required String id});
}
