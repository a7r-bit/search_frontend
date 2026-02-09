import 'package:flutter/material.dart';
import 'package:search_frontend/core/constants/index.dart';

class Node {
  final String id;
  final NodeType type;
  final String name;
  final String? description;
  final String? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Node({
    required this.id,
    required this.type,
    required this.name,
    required this.description,
    required this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'FileNode(id: $id, type: ${type.name}, name: $name, description: $description, parentId: $parentId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

enum NodeType {
  DIRECTORY(Icons.folder),
  DOCUMENT(Icons.file_present_rounded);

  final IconData icon;
  const NodeType(this.icon);
}
