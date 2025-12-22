import 'package:search_frontend/core/domain/entities/saved_directory.dart';
import 'package:search_frontend/core/domain/entities/toggle_liked_directory.dart';
import 'package:search_frontend/core/errors/error_mapper.dart';
import 'package:search_frontend/features/documents/data/datasources/saved_directory_remote_data_source.dart';
import 'package:search_frontend/features/documents/domain/repositories/saved_directory_repository.dart';

class SavedDirectoryRepositoryImpl implements SavedDirectoryRepository {
  final SavedDirectoryDataSource remoteDataSource;

  SavedDirectoryRepositoryImpl({required this.remoteDataSource});
  @override
  Future<List<SavedDirectory>> getSavedDirectories() async {
    try {
      final savedDirectories = await remoteDataSource.getSavedDirectories();
      return savedDirectories.map((directory) => directory.toDomain()).toList();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<ToggleLikedDirectory> toggleSavedDirectory({
    required String directoryId,
  }) async {
    try {
      final savedDirectory = await remoteDataSource.toggleSavedDirectory(
        directoryId: directoryId,
      );
      return savedDirectory.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
