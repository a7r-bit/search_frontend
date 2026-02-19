import 'package:search_frontend/core/domain/entities/node.dart';
import 'package:search_frontend/core/domain/entities/path_part.dart';
import 'package:search_frontend/core/errors/error_mapper.dart';
import 'package:search_frontend/features/documents/data/datasources/node_remote_data_source.dart';
import 'package:search_frontend/features/documents/domain/repositories/node_repository.dart';
import 'package:search_frontend/features/documents/presentation/widgets/directory_action_panel/directory_sort_menu.dart';

class NodeRepositoryImpl implements NodeRepository {
  final NodeRemoteDataSource remoteDataSource;

  NodeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Node>> getChildren(
    String? parentId,
    SortField sortField,
    SortOrder sortOrder,
    NodeType? nodeType,
  ) async {
    try {
      final fileNodes = await remoteDataSource.getChildren(
        parentId,
        sortField,
        sortOrder,
        nodeType,
      );
      return fileNodes.map((fileNode) => fileNode.toDomain()).toList();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<List<PathPart>> getPath(String id) async {
    try {
      final pathParts = await remoteDataSource.getPath(id);
      return pathParts.map((pathPart) => pathPart.toDomain()).toList();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<List<PathPart>> getRoot() async {
    try {
      final pathParts = await remoteDataSource.getRoot();
      return pathParts.map((pathPart) => pathPart.toDomain()).toList();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Node> createNode({
    required NodeType type,
    required String name,
    required String? description,
    required String? parentId,
  }) async {
    try {
      final node = await remoteDataSource.createNode(
        name: name,
        description: description,
        parentId: parentId,
        type: type,
      );
      return node.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Node> deleteNode({required String nodeId}) async {
    try {
      final fileNode = await remoteDataSource.deleteNode(nodeId: nodeId);
      return fileNode.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Node> updateNode({
    required String nodeId,
    required String? name,
    required String? description,
  }) async {
    try {
      final fileNode = await remoteDataSource.updateNode(
        nodeId: nodeId,
        name: name,
        description: description,
      );
      return fileNode.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Node> getNodeById({required String nodeId}) async {
    try {
      final fileNode = await remoteDataSource.getNodeById(nodeId: nodeId);
      return fileNode.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<Node> moveNode({
    required String nodeId,
    required String? newParentId,
  }) async {
    try {
      final fileNode = await remoteDataSource.moveNode(
        nodeId: nodeId,
        newParentId: newParentId,
      );
      return fileNode.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
