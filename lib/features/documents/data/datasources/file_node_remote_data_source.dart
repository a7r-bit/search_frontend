import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/data/models/file_node_model.dart';
import 'package:search_frontend/features/documents/data/models/path_part_model.dart';

abstract class FileNodeRemoteDataSource {
  Future<List<PathPartModel>> getRoot();
  Future<List<PathPartModel>> getPath(String? id);
  Future<List<FileNodeModel>> getChildren(String? parentId);
  Future<List<FileNodeModel>> searchFile(String searchQuery);
  Future<FileNodeModel> createDirectory({
    required String name,
    required String? parentId,
  });
  Future<FileNodeModel> createDocument({
    required String name,
    required String? description,
    required String directoryId,
  });

  Future<FileNodeModel> deleteDirectory({required String directoryId});
  Future<FileNodeModel> deleteDocument({required String documentId});

  Future<FileNodeModel> updateDirectory({
    required String directoryId,
    required String? name,
    required String? parentId,
  });

  Future<FileNodeModel> updateDocument({
    required String documentId,
    required String? title,
    required String? description,
    required String? directoryId,
  });
}

class DirectoryRemoteDataSourceImpl implements FileNodeRemoteDataSource {
  final ApiClient _apiClient;

  DirectoryRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<FileNodeModel>> getChildren(String? parentId) async {
    final response = await _apiClient.get(
      "/directories/children",
      queryParams: parentId != null ? {"parentId": parentId} : null,
    );
    final List<dynamic> data = response;

    return data
        .map((e) => FileNodeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<FileNodeModel>> searchFile(String searchQuery) async {
    final response = await _apiClient.get(
      "/directories/search",
      queryParams: {"searchQuery": searchQuery},
    );
    final List<dynamic> data = response;

    return data
        .map((e) => FileNodeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<FileNodeModel> createDirectory({
    required String name,
    required String? parentId,
  }) async {
    final Map<String, dynamic> response = await _apiClient.post(
      "/directories/",
      data: {"name": name, "parentId": parentId},
    );
    return FileNodeModel.fromJson(response);
  }

  @override
  Future<List<PathPartModel>> getPath(String? id) async {
    final response = await _apiClient.get("/directories/$id/path");
    final List<dynamic> data = response;
    return data
        .map((e) => PathPartModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<PathPartModel>> getRoot() async {
    final response = await _apiClient.get("/directories/path/root");
    final List<dynamic> data = response;
    return data
        .map((e) => PathPartModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<FileNodeModel> createDocument({
    required String name,
    required String? description,
    required String directoryId,
  }) async {
    final responce = await _apiClient.post(
      "/documents",
      data: {
        "title": name,
        "description": description,
        "directoryId": directoryId,
      },
    );
    return FileNodeModel.fromJson(responce);
  }

  @override
  Future<FileNodeModel> deleteDirectory({required String directoryId}) async {
    final responce = await _apiClient.delete("/directories/$directoryId");
    return FileNodeModel.fromJson(responce);
  }

  @override
  Future<FileNodeModel> deleteDocument({required String documentId}) async {
    final responce = await _apiClient.delete("/documents/$documentId");
    return FileNodeModel.fromJson(responce);
  }

  @override
  Future<FileNodeModel> updateDirectory({
    required String directoryId,
    required String? name,
    required String? parentId,
  }) async {
    final Map<String, dynamic> responce = await _apiClient.patch(
      "/directories/$directoryId",
      data: {"name": name, "parentId": parentId},
    );
    return FileNodeModel.fromJson(responce);
  }

  @override
  Future<FileNodeModel> updateDocument({
    required String documentId,
    required String? title,
    required String? description,
    required String? directoryId,
  }) async {
    final Map<String, dynamic> responce = await _apiClient.patch(
      "/documents/$documentId",
      data: {
        "title": title,
        "description": description,
        "directoryId": directoryId,
      },
    );
    return FileNodeModel.fromJson(responce);
  }
}
