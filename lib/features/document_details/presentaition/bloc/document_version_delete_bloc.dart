// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/document_details/domain/repositories/document_version_repository.dart';

import '../../../../core/domain/entities/index.dart';

part 'document_version_delete_event.dart';
part 'document_version_delete_state.dart';

class DocumentVersionDeleteBloc
    extends Bloc<DocumentVersionDeleteEvent, DocumentVersionDeleteState> {
  final DocumentVersionRepository documentVersionRepository;
  DocumentVersionDeleteBloc({required this.documentVersionRepository})
    : super(DocumentVersionDeleteInitial()) {
    on<DeleteDocumentVersionEvent>(_onDeleteDocumentVersionEvent);
  }

  Future<void> _onDeleteDocumentVersionEvent(
    DeleteDocumentVersionEvent event,
    Emitter<DocumentVersionDeleteState> emit,
  ) async {
    final previousState = state;
    try {
      emit(DocumentVersionDeleteLoading());
      final documentVersion = await documentVersionRepository
          .deleteDocumentVersionById(documentVersionId: event.doumentversionId);
      emit(DocumentVersionDeleteSuccess(documentVersion: documentVersion));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }
}
