part of 'document_version_update_bloc.dart';

sealed class DocumentVersionUpdateEvent extends Equatable {
  const DocumentVersionUpdateEvent();

  @override
  List<Object> get props => [];
}

class DocumentVersionUpdate extends DocumentVersionUpdateEvent {
  final String documentVersionId;
  final int verion;
  final String fileName;

  const DocumentVersionUpdate({
    required this.documentVersionId,
    required this.verion,
    required this.fileName,
  });

  @override
  List<Object> get props => [documentVersionId, verion, fileName];
}
