import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/features/documents/presentation/widgets/directory_action_panel/directory_sort_menu.dart';

abstract class NodeRepository {
  Future<Node> getNodeById({required String nodeId});

  Future<List<Node>> getChildren(
    String? parentId,
    SortField sortField,
    SortOrder sortOrder,
    NodeType? nodeType,
  );

  Future<Node> createNode({
    required NodeType type,
    required String name,
    required String? description,
    required String? parentId,
  });

  Future<List<PathPart>> getPath(String id);

  Future<List<PathPart>> getRoot();

  Future<Node> updateNode({
    required String nodeId,
    required String? name,
    required String? description,
  });

  Future<Node> moveNode({required String nodeId, required String? newParentId});

  Future<Node> deleteNode({required String nodeId});
}
