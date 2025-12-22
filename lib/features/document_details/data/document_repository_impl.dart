import 'package:search_frontend/core/domain/entities/document.dart';
import 'package:search_frontend/core/errors/error_mapper.dart';
import 'package:search_frontend/features/document_details/data/datasources/document_remote_data_source.dart';
import 'package:search_frontend/features/document_details/domain/repositories/document_repository.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentRemoteDataSource remoteDataSource;

  DocumentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Document> getDocumentById({required String id}) async {
    try {
      final document = await remoteDataSource.getDocumentById(id: id);
      return document.toDOmain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
