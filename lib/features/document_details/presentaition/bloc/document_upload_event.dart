part of 'document_upload_bloc.dart';

sealed class DocumentUploadEvent extends Equatable {
  const DocumentUploadEvent();

  @override
  List<Object> get props => [];
}

final class ResetFileEvent extends DocumentUploadEvent {}

final class PickFileEvent extends DocumentUploadEvent {}

final class AddFileEvent extends DocumentUploadEvent {
  final PlatformFile file;

  const AddFileEvent({required this.file});
  @override
  List<Object> get props => [file];
}

final class CreateDocumentVersion extends DocumentUploadEvent {
  final String nodeId;
  final PlatformFile file;

  const CreateDocumentVersion({required this.nodeId, required this.file});

  @override
  List<Object> get props => [nodeId, file];
}
