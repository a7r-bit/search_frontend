part of 'document_version_delete_bloc.dart';

sealed class DocumentVersionDeleteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class DeleteDocumentVersionEvent extends DocumentVersionDeleteEvent {
  final String doumentversionId;
  DeleteDocumentVersionEvent({required this.doumentversionId});

  @override
  List<Object> get props => [doumentversionId];
}
