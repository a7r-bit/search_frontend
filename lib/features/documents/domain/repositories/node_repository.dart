import 'package:search_frontend/core/domain/entities/index.dart';

abstract class NodeRepository {
  Future<List<Node>> getChildren(String? parentId);
  Future<List<Node>> searchFile(String searchQuery);
  Future<Node> createNode({
    required NodeType type,
    required String name,
    required String? parentId,
  });

  Future<Node> createDocument({
    required String name,
    required String? description,
    required String directoryId,
  });

  Future<List<PathPart>> getPath(String id);

  Future<List<PathPart>> getRoot();

  Future<Node> updateDirectory({
    required String directoryId,
    required String? name,
    required String? parentId,
  });

  Future<Node> updateDocument({
    required String documentId,
    required String? title,
    required String? description,
    required String? directoryId,
  });

  Future<Node> deleteDirectory({required String directoryId});

  Future<Node> deleteDocument({required String documentId});
}
