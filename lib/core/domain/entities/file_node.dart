class FileNode {
  final String id;
  final String type;
  final String name;
  final String? description;
  final String? parentId;
  final DateTime createdAt;
  final DateTime updatedAt;

  FileNode({
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
    return 'FileNode(id: $id, type: $type, name: $name, description: $description, parentId: $parentId, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
