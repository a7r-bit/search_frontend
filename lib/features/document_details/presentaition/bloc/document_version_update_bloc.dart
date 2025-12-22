import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/document_details/domain/repositories/document_version_repository.dart';

part 'document_version_update_event.dart';
part 'document_version_update_state.dart';

class DocumentVersionUpdateBloc
    extends Bloc<DocumentVersionUpdateEvent, DocumentVersionUpdateState> {
  final DocumentVersionRepository repository;
  DocumentVersionUpdateBloc({required this.repository})
    : super(DocumentVersionUpdateInitial()) {
    on<DocumentVersionUpdate>(_onDocumentVersionUpdate);
  }

  Future<void> _onDocumentVersionUpdate(
    DocumentVersionUpdate event,
    Emitter<DocumentVersionUpdateState> emit,
  ) async {
    final previousState = state;
    try {
      emit(DocumentVersionUpdating());
      final documentVersion = await repository.updateDocumentVersion(
        documentVersionId: event.documentVersionId,
        verion: event.verion,
        fileName: event.fileName,
      );
      emit(DocumentVersionUpdateSuccess(documentVersion: documentVersion));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }
}
