import 'package:search_frontend/core/domain/entities/file_node.dart';
import 'package:search_frontend/core/domain/entities/path_part.dart';
import 'package:search_frontend/core/errors/error_mapper.dart';
import 'package:search_frontend/features/documents/data/datasources/file_node_remote_data_source.dart';
import 'package:search_frontend/features/documents/domain/repositories/file_node_repository.dart';

class FileNodeRepositoryImpl implements FileNodeRepository {
  final FileNodeRemoteDataSource remoteDataSource;

  FileNodeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<FileNode>> getChildren(String? parentId) async {
    try {
      final fileNodes = await remoteDataSource.getChildren(parentId);
      return fileNodes.map((fileNode) => fileNode.toDomain()).toList();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<List<FileNode>> searchFile(String searchQuery) async {
    try {
      final fileNodes = await remoteDataSource.searchFile(searchQuery);
      return fileNodes.map((fileNode) => fileNode.toDomain()).toList();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<List<PathPart>> getPath(String? id) async {
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
  Future<FileNode> createDocument({
    required String name,
    required String? description,
    required String directoryId,
  }) async {
    try {
      final createdDocument = await remoteDataSource.createDocument(
        name: name,
        description: description,
        directoryId: directoryId,
      );
      return createdDocument.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<FileNode> createDirectory({
    required String name,
    required String? parentId,
  }) async {
    try {
      final fileNode = await remoteDataSource.createDirectory(
        name: name,
        parentId: parentId,
      );
      return fileNode.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<FileNode> deleteDirectory({required String directoryId}) async {
    try {
      final fileNode = await remoteDataSource.deleteDirectory(
        directoryId: directoryId,
      );
      return fileNode.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<FileNode> deleteDocument({required String documentId}) async {
    try {
      final fileNode = await remoteDataSource.deleteDocument(
        documentId: documentId,
      );
      return fileNode.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<FileNode> updateDirectory({
    required String directoryId,
    required String? name,
    required String? parentId,
  }) async {
    try {
      final fileNode = await remoteDataSource.updateDirectory(
        directoryId: directoryId,
        name: name,
        parentId: parentId,
      );
      return fileNode.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }

  @override
  Future<FileNode> updateDocument({
    required String documentId,
    required String? title,
    required String? description,
    required String? directoryId,
  }) async {
    try {
      final fileNode = await remoteDataSource.updateDocument(
        documentId: documentId,
        title: title,
        description: description,
        directoryId: directoryId,
      );
      return fileNode.toDomain();
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
