import 'package:search_frontend/core/domain/entities/node.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/data/models/node_model.dart';
import 'package:search_frontend/features/documents/data/models/path_part_model.dart';

abstract class FileNodeRemoteDataSource {
  Future<List<PathPartModel>> getRoot();
  Future<List<PathPartModel>> getPath(String id);
  Future<List<NodeModel>> getChildren(String? parentId);
  Future<List<NodeModel>> searchFile(String searchQuery);
  Future<NodeModel> createNode({
    required NodeType type,
    required String name,
    required String? parentId,
  });
  Future<NodeModel> createDocument({
    required String name,
    required String? description,
    required String directoryId,
  });

  Future<NodeModel> deleteDirectory({required String directoryId});
  Future<NodeModel> deleteDocument({required String documentId});

  Future<NodeModel> updateDirectory({
    required String directoryId,
    required String? name,
    required String? parentId,
  });

  Future<NodeModel> updateDocument({
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
  Future<List<NodeModel>> getChildren(String? parentId) async {
    final response = await _apiClient.get(
      "/node/children",
      queryParams: parentId != null ? {"parentId": parentId} : null,
      // queryParams: {"parentId": parentId},
    );
    final List<dynamic> data = response;

    return data
        .map((e) => NodeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<NodeModel>> searchFile(String searchQuery) async {
    final response = await _apiClient.get(
      "/directories/search",
      queryParams: {"searchQuery": searchQuery},
    );
    final List<dynamic> data = response;

    return data
        .map((e) => NodeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<NodeModel> createNode({
    required NodeType type,
    required String name,
    required String? parentId,
  }) async {
    final Map<String, dynamic> response = await _apiClient.post(
      "/node/",
      data: {"name": name, "type": type, "parentId": parentId},
    );
    return NodeModel.fromJson(response);
  }

  @override
  Future<List<PathPartModel>> getPath(String id) async {
    final response = await _apiClient.get("/node/$id/path");
    final List<dynamic> data = response;
    return data
        .map((e) => PathPartModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<PathPartModel>> getRoot() async {
    final response = await _apiClient.get("/node/path/root");
    final List<dynamic> data = response;
    return data
        .map((e) => PathPartModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<NodeModel> createDocument({
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
    return NodeModel.fromJson(responce);
  }

  @override
  Future<NodeModel> deleteDirectory({required String directoryId}) async {
    final responce = await _apiClient.delete("/directories/$directoryId");
    return NodeModel.fromJson(responce);
  }

  @override
  Future<NodeModel> deleteDocument({required String documentId}) async {
    final responce = await _apiClient.delete("/documents/$documentId");
    return NodeModel.fromJson(responce);
  }

  @override
  Future<NodeModel> updateDirectory({
    required String directoryId,
    required String? name,
    required String? parentId,
  }) async {
    final Map<String, dynamic> responce = await _apiClient.patch(
      "/directories/$directoryId",
      data: {"name": name, "parentId": parentId},
    );
    return NodeModel.fromJson(responce);
  }

  @override
  Future<NodeModel> updateDocument({
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
    return NodeModel.fromJson(responce);
  }
}
