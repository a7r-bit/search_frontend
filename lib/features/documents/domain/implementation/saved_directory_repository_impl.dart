import 'package:search_frontend/core/domain/entities/node.dart';
import 'package:search_frontend/core/errors/error_mapper.dart';
import 'package:search_frontend/features/documents/data/datasources/saved_node_remote_data_source.dart';
import 'package:search_frontend/features/documents/domain/repositories/saved_directory_repository.dart';

class SavedDirectoryRepositoryImpl implements SavedDirectoryRepository {
  final SavedNodeDataSource remoteDataSource;

  SavedDirectoryRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<Node>> getSavedDirectories() async {
    try {
      final savedNodes = await remoteDataSource.getSavedNode();
      return savedNodes.map((node) => node.toDomain()).toList();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Node> toggleSavedDirectory({required String directoryId}) async {
    try {
      final savedNodes = await remoteDataSource.toggleSavedNode(
        nodeId: directoryId,
      );
      return savedNodes.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
