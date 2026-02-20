part of 'node_bloc.dart';

sealed class NodeEvent extends Equatable {
  const NodeEvent();

  @override
  List<Object?> get props => [];
}

class CreateNode extends NodeEvent {
  final NodeType type;
  final String name;
  final String? parentId;
  final String? description;

  const CreateNode({
    required this.description,
    required this.type,
    required this.name,
    required this.parentId,
  });
  @override
  List<Object?> get props => [parentId, name, type, description];
}

class UpdateNode extends NodeEvent {
  final String nodeId;
  final String? name;
  final String? description;

  const UpdateNode({
    required this.nodeId,
    required this.name,
    required this.description,
  });

  @override
  List<Object?> get props => [name, description];
}

class MoveNode extends NodeEvent {
  final String nodeId;
  final String? newParentId;

  const MoveNode({required this.nodeId, required this.newParentId});

  @override
  List<Object?> get props => [nodeId, newParentId];
}

class DeleteNode extends NodeEvent {
  final String nodeId;

  const DeleteNode({required this.nodeId});

  @override
  List<Object?> get props => [nodeId];
}
