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

  const LoadChildren({
    required this.parentId,
    required this.sortField,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [parentId, sortField, sortOrder];
}

class LoadPath extends NodeExplorerEvent {
  final String? directoryId;

  const LoadPath({required this.directoryId});

  @override
  List<Object?> get props => [directoryId];
}
