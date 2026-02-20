part of 'node_explorer_bloc.dart';

sealed class NodeExplorerState extends Equatable {
  const NodeExplorerState();

  @override
  List<Object?> get props => [];
}

final class NodeLoadInitial extends NodeExplorerState {}

final class NodeLoadLoading extends NodeExplorerState {}

final class NodeLoadLoaded extends NodeExplorerState {
  final List<Node> children;
  final List<PathPart> path;
  const NodeLoadLoaded({required this.children, required this.path});

  @override
  List<Object?> get props => [children, path];
}

final class LoadingError extends NodeExplorerState {
  final Failure failure;

  const LoadingError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
