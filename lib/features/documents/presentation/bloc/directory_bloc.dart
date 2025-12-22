import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/documents/domain/repositories/file_node_repository.dart';

part 'directory_event.dart';
part 'directory_state.dart';

class DirectoryBloc extends Bloc<DirectoryEvent, DirectoryState> {
  final FileNodeRepository repository;
  DirectoryBloc({required this.repository}) : super(DirectoryInitial()) {
    on<LoadChildren>(_onLoadChildren);
    on<LoadPath>(_onLoadPath);
    on<DeleteDirectory>(_onDeleteDirectory);
    on<DeleteDocument>(_onDeleteDocument);
  }

  Future<void> _onLoadChildren(
    LoadChildren event,
    Emitter<DirectoryState> emit,
  ) async {
    final previousState = state;
    emit(DirectoryLoading());
    try {
      final children = await repository.getChildren(event.parentId);
      final path = event.parentId != null
          ? await repository.getPath(event.parentId!)
          : await repository.getRoot();

      emit(DirectoryLoaded(children: children, path: path));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }

  Future<void> _onLoadPath(LoadPath event, Emitter<DirectoryState> emit) async {
    emit(DirectoryLoading());
    try {} on Failure catch (e) {
      addError(e);
      emit(DirectoryError(failure: e));
    }
  }

  Future<void> _onDeleteDirectory(
    DeleteDirectory event,
    Emitter<DirectoryState> emit,
  ) async {
    final previousState = state;

    emit(DirectoryLoading());
    try {
      await repository.deleteDirectory(directoryId: event.directoryId);
      add(LoadChildren(parentId: event.parentId));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }

  Future<void> _onDeleteDocument(
    DeleteDocument event,
    Emitter<DirectoryState> emit,
  ) async {
    final previousState = state;
    emit(DirectoryLoading());
    try {
      await repository.deleteDocument(documentId: event.documentId);
      // Перезагружаем список после удаления
      add(LoadChildren(parentId: event.parentId));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }
}
