part of 'node_bloc.dart';

sealed class NodeState extends Equatable {
  const NodeState();

  @override
  List<Object> get props => [];
}

final class NodeInitial extends NodeState {}

final class NodeLoading extends NodeState {}

final class NodeLoaded extends NodeState {
  final Node node;

  const NodeLoaded({required this.node});

  @override
  List<Object> get props => [node];
}

final class NodeUpdated extends NodeState {
  final Node node;
  const NodeUpdated({required this.node});

  @override
  List<Object> get props => [node];
}

final class NodeMoved extends NodeState {
  final Node node;
  const NodeMoved({required this.node});

  @override
  List<Object> get props => [node];
}

final class NodeDeleted extends NodeState {
  final Node node;
  const NodeDeleted({required this.node});

  @override
  List<Object> get props => [node];
}

final class NodeError extends NodeState {
  final Failure failure;

  const NodeError({required this.failure});

  @override
  List<Object> get props => [failure];
}
