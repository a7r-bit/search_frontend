import 'package:search_frontend/core/domain/entities/node.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/data/models/node_model.dart';
import 'package:search_frontend/features/documents/data/models/path_part_model.dart';
import 'package:search_frontend/features/documents/presentation/widgets/directory_action_panel/directory_sort_menu.dart';

abstract class NodeRemoteDataSource {
  Future<NodeModel> getNodeById({required String nodeId});

  Future<List<PathPartModel>> getRoot();

  Future<List<PathPartModel>> getPath(String id);

  Future<List<NodeModel>> getChildren(
    String? parentId,
    SortField sortField,
    SortOrder sortOrder,
  );

  // Future<List<NodeModel>> searchFile(String searchQuery);

  Future<NodeModel> createNode({
    required NodeType type,
    required String name,
    required String? description,
    required String? parentId,
  });

  Future<NodeModel> deleteNode({required String nodeId});

  Future<NodeModel> updateNode({
    required String nodeId,
    required String? name,
    required String? description,
  });

  Future<NodeModel> moveNode({
    required String nodeId,
    required String newParentId,
  });
}

class DirectoryRemoteDataSourceImpl implements NodeRemoteDataSource {
  final ApiClient _apiClient;

  DirectoryRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<NodeModel>> getChildren(
    String? parentId,
    SortField sortField,
    SortOrder sortOrder,
  ) async {
    final response = await _apiClient.get(
      "/node/children",
      queryParams: {
        if (parentId != null) "parentId": parentId,
        "sort": "${sortField.name}:${sortOrder.name}",
      },
      // parentId != null
      //     ? {
      //         "parentId": parentId,
      //         "sort": "${sortField.name}:${sortOrder.name}",
      //       }
      //     : null,
    );
    final List<dynamic> data = response;

    return data
        .map((e) => NodeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // @override
  // Future<List<NodeModel>> searchFile(String searchQuery) async {
  //   final response = await _apiClient.get(
  //     "/directories/search",
  //     queryParams: {"searchQuery": searchQuery},
  //   );
  //   final List<dynamic> data = response;

  //   return data
  //       .map((e) => NodeModel.fromJson(e as Map<String, dynamic>))
  //       .toList();
  // }

  @override
  Future<NodeModel> createNode({
    required NodeType type,
    required String name,
    required String? description,
    required String? parentId,
  }) async {
    final Map<String, dynamic> response = await _apiClient.post(
      "/node/",
      data: {
        "name": name,
        "type": type.name,
        "parentId": parentId,
        "description": description,
      },
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
  Future<NodeModel> deleteNode({required String nodeId}) async {
    final responce = await _apiClient.delete("/node/$nodeId");
    return NodeModel.fromJson(responce);
  }

  @override
  Future<NodeModel> updateNode({
    required String nodeId,
    required String? name,
    required String? description,
  }) async {
    final Map<String, dynamic> responce = await _apiClient.patch(
      "/node/$nodeId",
      data: {"name": name, "description": description},
    );
    return NodeModel.fromJson(responce);
  }

  @override
  Future<NodeModel> getNodeById({required String nodeId}) async {
    final Map<String, dynamic> responce = await _apiClient.get("/node/$nodeId");
    return NodeModel.fromJson(responce);
  }

  @override
  Future<NodeModel> moveNode({
    required String nodeId,
    required String newParentId,
  }) async {
    final Map<String, dynamic> responce = await _apiClient.post(
      "/node/$nodeId/move",
      data: {"newParentId": newParentId},
    );
    return NodeModel.fromJson(responce);
  }
}
