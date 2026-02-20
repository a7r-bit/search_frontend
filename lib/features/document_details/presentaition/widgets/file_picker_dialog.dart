import 'dart:developer';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_upload_bloc.dart';

class FilePickerDialog extends StatelessWidget {
  final String documetnId;
  const FilePickerDialog({super.key, required this.documetnId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      titlePadding: EdgeInsets.only(
        left: AppPadding.large,
        right: AppPadding.large,
        top: AppPadding.medium,
        bottom: AppPadding.small,
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Создание документа",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          Text(
            "Создание новой версии документа",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      contentPadding: EdgeInsets.only(
        left: AppPadding.large,
        right: AppPadding.large,
        bottom: AppPadding.large,
      ),
      content: Container(
        width: 340,
        height: 340,
        // padding: EdgeInsets.all(AppPadding.small),
        child: DialogBody(nodeId: documetnId),
      ),
    );
  }
}

class DialogBody extends StatefulWidget {
  final String nodeId;
  const DialogBody({super.key, required this.nodeId});

  @override
  State<DialogBody> createState() => _DialogBodyState();
}

class _DialogBodyState extends State<DialogBody> {
  bool isHovering = false;
  late DropzoneViewController dropzoneController;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        strokeCap: StrokeCap.round,
        radius: Radius.circular(AppRadius.small),
        color: Theme.of(context).colorScheme.outline,
        dashPattern: isHovering ? [5, 4] : [10, 8],
        strokeWidth: 2,
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: isHovering
              ? Theme.of(context).colorScheme.surfaceDim
              : Colors.transparent,

          // ? Theme.of(context).colorScheme.primaryContainer
          borderRadius: BorderRadius.circular(AppRadius.small),
        ),
        child: BlocBuilder<DocumentUploadBloc, DocumentUploadState>(
          builder: (context, state) {
            if (state is DocumentUploadInitial) {
              return Stack(
                children: [
                  if (kIsWeb)
                    DropzoneView(
                      onCreated: (controller) =>
                          dropzoneController = controller,
                      onDropInvalid: (value) => context.read<ErrorBloc>().add(
                        ErrorReport(failure: Failure("Недопустимый тип файла")),
                      ),
                      onHover: () => setState(() => isHovering = true),
                      onLeave: () => setState(() => isHovering = false),
                      onDropFile: (file) async {
                        setState(() => isHovering = false);
                        final name = await dropzoneController.getFilename(file);
                        final mime = await dropzoneController.getFileMIME(file);
                        final bytes = await dropzoneController.getFileData(
                          file,
                        );
                        final size = await dropzoneController.getFileSize(file);

                        // Отправка события в Bloc
                        context.read<DocumentUploadBloc>().add(
                          AddFileEvent(
                            file: PlatformFile(
                              name: name,
                              size: size,
                              bytes: bytes,
                            ),
                          ),
                        );
                      },

                      mime: [
                        'application/pdf',
                        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
                        'image/png',
                      ],
                      operation: DragOperation.copy,
                    ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_download_outlined,
                        size: 36,
                        color: Theme.of(context).colorScheme.primary,
                      ),

                      SizedBox(height: SizeConfig.blockSizeVertical * 2),
                      Text(
                        "Выберите файл или перетяниите его сюда",
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'PDF, DOCX, PNG размером до 5МБ',
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: SizeConfig.blockSizeVertical),
                      TextButton(
                        onPressed: () => context.read<DocumentUploadBloc>().add(
                          PickFileEvent(),
                        ),
                        child: Text("Загрузить файл"),
                      ),
                    ],
                  ),
                ],
              );
            }
            if (state is FilePicked) {
              return Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          getFileIcon(state.file.extension ?? ""),
                          size: 36,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        SizedBox(height: 20),
                        Text(state.file.name, textAlign: TextAlign.center),
                        SizedBox(height: 20),
                        Text(_formatFileSize(state.file.size)),
                        SizedBox(height: 20),

                        TextButton(
                          onPressed: () => {
                            log(widget.nodeId, name: "NODE_ID"),
                            context.read<DocumentUploadBloc>().add(
                              CreateDocumentVersion(
                                nodeId: widget.nodeId,
                                file: state.file,
                              ),
                            ),
                          },
                          child: Text("Создать"),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: IconButton(
                      onPressed: () => context.read<DocumentUploadBloc>().add(
                        ResetFileEvent(),
                      ),
                      icon: Icon(Icons.close),
                    ),
                  ),
                ],
              );
            }
            if (state is Uploading) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator.adaptive(
                      value: state.progress,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${(state.progress * 100).toStringAsFixed(1)}% загружено",
                  ),
                ],
              );
            }

            if (state is UploadSuccess) {
              Navigator.of(context).pop(state.documentVersion);
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }

  IconData getFileIcon(String extentious) {
    final ext = extentious.toLowerCase();

    if (ext.endsWith('pdf')) {
      return Icons.picture_as_pdf;
    } else if (ext.endsWith('doc') || ext.endsWith('docx')) {
      return Icons.description;
    } else if (ext.endsWith('png') ||
        ext.endsWith('jpg') ||
        ext.endsWith('jpeg')) {
      return Icons.image;
    } else {
      return Icons.insert_drive_file;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes >= 1024 * 1024) {
      return '${(bytes / 1024 / 1024).toStringAsFixed(2)} MB';
    } else {
      return '${(bytes / 1024).toStringAsFixed(0)} KB';
    }
  }
}
