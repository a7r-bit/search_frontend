part of 'node_explorer_bloc.dart';

sealed class NodeExplorerEvent extends Equatable {
  const NodeExplorerEvent();

  @override
  List<Object?> get props => [];
}

class LoadChildren extends NodeExplorerEvent {
  final String? parentId;
  final SortField sortField;
  final SortOrder sortOrder;
  final NodeType? nodeType;

  const LoadChildren({
    required this.parentId,
    this.sortField = SortField.name,
    this.sortOrder = SortOrder.asc,
    this.nodeType,
  });

  @override
  List<Object?> get props => [parentId, sortField, sortOrder, nodeType];
}

class LoadPath extends NodeExplorerEvent {
  final String? directoryId;

  const LoadPath({required this.directoryId});

  @override
  List<Object?> get props => [directoryId];
}
