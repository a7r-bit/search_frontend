import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/documents/domain/repositories/node_repository.dart';
import 'package:search_frontend/features/documents/presentation/widgets/directory_action_panel/directory_sort_menu.dart';

part 'node_explorer_event.dart';
part 'node_explorer_state.dart';

class NodeExplorerBloc extends Bloc<NodeExplorerEvent, NodeExplorerState> {
  final NodeRepository repository;
  NodeExplorerBloc({required this.repository}) : super(NodeLoadInitial()) {
    on<LoadChildren>(_onLoadChildren);
    on<LoadPath>(_onLoadPath);
  }

  Future<void> _onLoadChildren(
    LoadChildren event,
    Emitter<NodeExplorerState> emit,
  ) async {
    log(
      'Loading children for node ${event.parentId} with sort ${event.sortField} ${event.sortOrder}',
    );
    final previousState = state;
    emit(NodeLoadLoading());
    try {
      final children = await repository.getChildren(
        event.parentId,
        event.sortField,
        event.sortOrder,
        event.nodeType,
      );
      final path = event.parentId != null
          ? await repository.getPath(event.parentId!)
          : await repository.getRoot();

      emit(NodeLoadLoaded(children: children, path: path));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }

  Future<void> _onLoadPath(
    LoadPath event,
    Emitter<NodeExplorerState> emit,
  ) async {
    emit(NodeLoadLoading());
    try {} on Failure catch (e) {
      addError(e);
      emit(LoadingError(failure: e));
    }
  }
}
