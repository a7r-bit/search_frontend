import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/document_details/domain/repositories/document_version_repository.dart';
import 'package:search_frontend/features/documents/domain/repositories/node_repository.dart';
part 'document_details_event.dart';
part 'document_details_state.dart';

class DocumentDetailsBloc
    extends Bloc<DocumentDetailsEvent, DocumentDetailsState> {
  final NodeRepository nodeRepository;
  final DocumentVersionRepository documentVersionRepository;
  DocumentDetailsBloc({
    required this.nodeRepository,
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
      final node = await nodeRepository.getNodeById(nodeId: event.nodeId);
      final documentversions = await documentVersionRepository
          .getDocumentVersionsByNodeId(
            nodeId: event.nodeId,
            fileName: event.fileName,
            conversionStatus: event.conversionStatus,
            sortOrder: event.sortOrder,
            sortParam: event.sortParam,
          );

      emit(
        DocumentDetailsLoaded(
          node: node,
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
      final node = await nodeRepository.getNodeById(
        nodeId: previousState.node.id,
      );

      final documentversions = await documentVersionRepository
          .getDocumentVersionsByNodeId(
            nodeId: node.id,
            fileName: previousState.fileName,
            conversionStatus: previousState.conversionStatus,
            sortOrder: previousState.sortOrder,
            sortParam: previousState.sortParam,
          );

      emit(
        DocumentDetailsLoaded(
          node: node,
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
