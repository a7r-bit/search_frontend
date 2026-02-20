import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/documents/domain/repositories/node_repository.dart';

part 'node_event.dart';
part 'node_state.dart';

class NodeBloc extends Bloc<NodeEvent, NodeState> {
  final NodeRepository repository;
  NodeBloc({required this.repository}) : super(NodeInitial()) {
    on<CreateNode>(_onCreateNode);
    on<UpdateNode>(_onUpdateNode);
    on<MoveNode>(_onMoveNode);
    on<DeleteNode>(_onDeleteNode);
  }
  Future<void> _onCreateNode(CreateNode event, Emitter<NodeState> emit) async {
    final previousState = state;
    emit(NodeLoading());
    try {
      final node = await repository.createNode(
        name: event.name,
        parentId: event.parentId,
        type: event.type,
        description: event.description,
      );
      emit(NodeLoaded(node: node));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }

  Future<void> _onUpdateNode(UpdateNode event, Emitter<NodeState> emit) async {
    final previousState = state;
    emit(NodeLoading());
    try {
      final node = await repository.updateNode(
        nodeId: event.nodeId,
        name: event.name,
        description: event.description,
      );
      emit(NodeUpdated(node: node));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }

  Future<void> _onMoveNode(MoveNode event, Emitter<NodeState> emit) async {
    final previousState = state;
    emit(NodeLoading());
    try {
      final node = await repository.moveNode(
        nodeId: event.nodeId,
        newParentId: event.newParentId,
      );
      emit(NodeMoved(node: node));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }

  Future<void> _onDeleteNode(DeleteNode event, Emitter<NodeState> emit) async {
    final previousState = state;
    emit(NodeLoading());
    try {
      final node = await repository.deleteNode(nodeId: event.nodeId);
      emit(NodeDeleted(node: node));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }
}
