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
      final savedDirectories = await remoteDataSource.getSavedNode();
      return savedDirectories.map((directory) => directory.toDomain()).toList();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Node> toggleSavedDirectory({required String directoryId}) async {
    try {
      final savedDirectory = await remoteDataSource.toggleSavedNode(
        nodeId: directoryId,
      );
      return savedDirectory.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
