part of 'document_upload_bloc.dart';

sealed class DocumentUploadState extends Equatable {
  const DocumentUploadState();

  @override
  List<Object> get props => [];
}

final class DocumentUploadInitial extends DocumentUploadState {}

class FilePicked extends DocumentUploadState {
  final PlatformFile file;

  const FilePicked({required this.file});
}

class Uploading extends DocumentUploadState {
  final double progress;

  const Uploading({required this.progress});
}

class UploadSuccess extends DocumentUploadState {
  final DocumentVersion documentVersion;

  const UploadSuccess({required this.documentVersion});
}
