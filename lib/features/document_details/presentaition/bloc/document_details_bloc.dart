import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/document_details/domain/repositories/document_repository.dart';
import 'package:search_frontend/features/document_details/domain/repositories/document_version_repository.dart';
part 'document_details_event.dart';
part 'document_details_state.dart';

class DocumentDetailsBloc
    extends Bloc<DocumentDetailsEvent, DocumentDetailsState> {
  final DocumentRepository documentRepository;
  final DocumentVersionRepository documentVersionRepository;
  DocumentDetailsBloc({
    required this.documentRepository,
    required this.documentVersionRepository,
  }) : super(DocumentDetailsInitial()) {
    on<LoadDocumentDetails>(_onLoadDocumentDetails);
    on<ReloadDocumentDetails>(_onReloadDocumentDetails);
  }

  Future<void> _onLoadDocumentDetails(
    LoadDocumentDetails event,
    Emitter<DocumentDetailsState> emit,
  ) async {
    final previousState = state;

    emit(DocumentDetailsLoading());
    try {
      final document = await documentRepository.getDocumentById(
        id: event.documentId,
      );
      final documentversions = await documentVersionRepository
          .getDocumentVersionsByDocumentId(
            documentId: event.documentId,
            fileName: event.fileName,
            conversionStatus: event.conversionStatus,
            sortOrder: event.sortOrder,
            sortParam: event.sortParam,
          );

      emit(
        DocumentDetailsLoaded(
          document: document,
          documentVersions: documentversions,
          fileName: event.fileName,
          conversionStatus: event.conversionStatus,
          sortOrder: event.sortOrder,
          sortParam: event.sortParam,
        ),
      );
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }

  Future<void> _onReloadDocumentDetails(
    ReloadDocumentDetails event,
    Emitter<DocumentDetailsState> emit,
  ) async {
    final previousState = state as DocumentDetailsLoaded;

    emit(DocumentDetailsLoading());
    try {
      final document = await documentRepository.getDocumentById(
        id: previousState.document.id,
      );
      final documentversions = await documentVersionRepository
          .getDocumentVersionsByDocumentId(
            documentId: document.id,
            fileName: previousState.fileName,
            conversionStatus: previousState.conversionStatus,
            sortOrder: previousState.sortOrder,
            sortParam: previousState.sortParam,
          );

      emit(
        DocumentDetailsLoaded(
          document: document,
          documentVersions: documentversions,
          fileName: previousState.fileName,
          conversionStatus: previousState.conversionStatus,
          sortOrder: previousState.sortOrder,
          sortParam: previousState.sortParam,
        ),
      );
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }
}
