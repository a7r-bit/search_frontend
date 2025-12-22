import 'package:search_frontend/core/domain/entities/index.dart';

abstract class SavedDirectoryRepository {
  Future<List<SavedDirectory>> getSavedDirectories();
  Future<ToggleLikedDirectory> toggleSavedDirectory({
    required String directoryId,
  });
}
