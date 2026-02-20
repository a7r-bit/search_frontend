import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/document_details/domain/repositories/document_version_repository.dart';

part 'document_upload_event.dart';
part 'document_upload_state.dart';

class DocumentUploadBloc
    extends Bloc<DocumentUploadEvent, DocumentUploadState> {
  final DocumentVersionRepository documentVersionRepository;
  DocumentUploadBloc({required this.documentVersionRepository})
    : super(DocumentUploadInitial()) {
    on<ResetFileEvent>(_onResetFileEvent);
    on<AddFileEvent>(_onAddFileEvent);
    on<PickFileEvent>(_onPickFileEvent);
    on<CreateDocumentVersion>(_onCreateDocumentVersion);
  }

  Future<void> _onAddFileEvent(
    AddFileEvent event,
    Emitter<DocumentUploadState> emit,
  ) async {
    emit(FilePicked(file: event.file));
  }

  Future<void> _onResetFileEvent(
    ResetFileEvent event,
    Emitter<DocumentUploadState> emit,
  ) async {
    emit(DocumentUploadInitial());
  }

  Future<void> _onPickFileEvent(
    PickFileEvent event,
    Emitter<DocumentUploadState> emit,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (result != null && result.files.isNotEmpty) {
      emit(FilePicked(file: result.files.last));
    }
  }

  Future<void> _onCreateDocumentVersion(
    CreateDocumentVersion event,
    Emitter<DocumentUploadState> emit,
  ) async {
    final previousState = state;
    try {
      MultipartFile multipartFile;
      if (kIsWeb) {
        multipartFile = MultipartFile.fromBytes(
          event.file.bytes!,
          filename: event.file.name,
        );
      } else {
        multipartFile = await MultipartFile.fromFile(
          event.file.path!,
          filename: event.file.name,
        );
      }

      final documentVersion = await documentVersionRepository
          .createDocumentVersion(
            nodeId: event.nodeId,
            multipartFile: multipartFile,
            onProgress: (sent, total) {
              emit(Uploading(progress: sent / total));
            },
          );

      emit(UploadSuccess(documentVersion: documentVersion));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }
}
