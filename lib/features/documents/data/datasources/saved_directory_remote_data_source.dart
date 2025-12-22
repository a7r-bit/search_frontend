import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/data/models/saved_directory_model.dart';
import 'package:search_frontend/features/documents/data/models/toggle_liked_directory_model.dart';

abstract class SavedDirectoryDataSource {
  Future<List<SavedDirectoryModel>> getSavedDirectories();
  Future<ToggleLikedDirectoryModel> toggleSavedDirectory({
    required String directoryId,
  });
}

class SavedDirectoryRemoteDataSourceImpl implements SavedDirectoryDataSource {
  final ApiClient _apiClient;

  SavedDirectoryRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<SavedDirectoryModel>> getSavedDirectories() async {
    final response = await _apiClient.get("/liked-directory");

    final List<dynamic> data = response;

    return data
        .map((e) => SavedDirectoryModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ToggleLikedDirectoryModel> toggleSavedDirectory({
    required String directoryId,
  }) async {
    final Map<String, dynamic> response = await _apiClient.post(
      "/liked-directory",
      data: {"directoryId": directoryId},
    );

    return ToggleLikedDirectoryModel.fromJson(response);
  }
}
