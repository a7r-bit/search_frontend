import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/documents/domain/repositories/node_repository.dart';

part 'dialog_event.dart';
part 'dialog_state.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  final NodeRepository repository;
  DialogBloc({required this.repository}) : super(DialogInitial()) {
    on<CreateNode>(_onCreateNode);
    on<CreateDocument>(_onCreateDocument);
    on<RenameDirectory>(_onRenameDirectory);
    on<RenameDocument>(_onRenameDocument);
  }
  Future<void> _onCreateNode(
    CreateNode event,
    Emitter<DialogState> emit,
  ) async {
    final previousState = state;
    emit(DialogLoading());
    try {
      final fileNode = await repository.createNode(
        name: event.name,
        parentId: event.parentId,
        type: event.type,
      );
      emit(DialogLoaded(fileNode: fileNode));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }

  Future<void> _onCreateDocument(
    CreateDocument event,
    Emitter<DialogState> emit,
  ) async {
    final previousState = state;
    emit(DialogLoading());
    try {
      final fileNode = await repository.createDocument(
        name: event.name,
        description: event.description,
        directoryId: event.directoryId,
      );
      emit(DialogLoaded(fileNode: fileNode));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }

  Future<void> _onRenameDirectory(
    RenameDirectory event,
    Emitter<DialogState> emit,
  ) async {
    final previousState = state;
    emit(DialogLoading());
    try {
      final fileNode = await repository.updateDirectory(
        directoryId: event.directoryId,
        name: event.name,
        parentId: event.parentId,
      );
      emit(DialogDirectoryRenamed(fileNode: fileNode));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }

  Future<void> _onRenameDocument(
    RenameDocument event,
    Emitter<DialogState> emit,
  ) async {
    final previousState = state;
    emit(DialogLoading());
    try {
      final fileNode = await repository.updateDocument(
        documentId: event.documentId,
        title: event.title,
        description: event.description,
        directoryId: event.directoryId,
      );
      emit(DialogDirectoryRenamed(fileNode: fileNode));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }
}
