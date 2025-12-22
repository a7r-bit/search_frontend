import 'package:search_frontend/core/domain/entities/index.dart';

abstract class FileNodeRepository {
  Future<List<FileNode>> getChildren(String? parentId);
  Future<List<FileNode>> searchFile(String searchQuery);
  Future<FileNode> createDirectory({
    required String name,
    required String? parentId,
  });

  Future<FileNode> createDocument({
    required String name,
    required String? description,
    required String directoryId,
  });

  Future<List<PathPart>> getPath(String? id);

  Future<List<PathPart>> getRoot();

  Future<FileNode> updateDirectory({
    required String directoryId,
    required String? name,
    required String? parentId,
  });

  Future<FileNode> updateDocument({
    required String documentId,
    required String? title,
    required String? description,
    required String? directoryId,
  });

  Future<FileNode> deleteDirectory({required String directoryId});

  Future<FileNode> deleteDocument({required String documentId});
}
