import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/data/models/node_model.dart';

abstract class SavedNodeDataSource {
  Future<List<NodeModel>> getSavedNode();
  Future<NodeModel> toggleSavedNode({required String nodeId});
}

class SavedNodeRemoteDataSourceImpl implements SavedNodeDataSource {
  final ApiClient _apiClient;

  SavedNodeRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<NodeModel>> getSavedNode() async {
    final response = await _apiClient.get("/liked-node");

    final List<dynamic> data = response;

    return data
        .map((e) => NodeModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<NodeModel> toggleSavedNode({required String nodeId}) async {
    final Map<String, dynamic> response = await _apiClient.post(
      "/liked-node",
      data: {"nodeId": nodeId},
    );

    return NodeModel.fromJson(response);
  }
}
