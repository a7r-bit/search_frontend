import 'package:search_frontend/core/domain/entities/index.dart';

abstract class SavedDirectoryRepository {
  Future<List<Node>> getSavedDirectories();
  Future<Node> toggleSavedDirectory({required String directoryId});
}
