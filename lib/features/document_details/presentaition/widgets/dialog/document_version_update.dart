import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_version_update_bloc.dart';

class DocumentVersionUpdateDialog extends StatefulWidget {
  final DocumentVersion documentVersion;
  const DocumentVersionUpdateDialog({super.key, required this.documentVersion});

  @override
  State<DocumentVersionUpdateDialog> createState() =>
      _DocumentVersionUpdateDialogState();
}

class _DocumentVersionUpdateDialogState
    extends State<DocumentVersionUpdateDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _fileNameController;
  late TextEditingController _versionNumberController;

  @override
  void initState() {
    super.initState();
    _fileNameController = TextEditingController(
      text: widget.documentVersion.mediaFile?.fileName,
    );
    _versionNumberController = TextEditingController(
      text: widget.documentVersion.version.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DocumentVersionUpdateBloc, DocumentVersionUpdateState>(
      listener: (context, state) {
        if (state is DocumentVersionUpdateSuccess) {
          Navigator.pop(context, state.documentVersion);
        }
      },
      child: AlertDialog.adaptive(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Обновление версии документа",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),

        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Название файла",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 2),
              TextFormField(
                controller: _fileNameController,
                autovalidateMode: AutovalidateMode.onUnfocus,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Название обязательно";
                  }
                  return null;
                },
              ),
              SizedBox(height: 2),
              Text(
                "Версия документа",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 2),
              TextFormField(
                controller: _versionNumberController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
                autovalidateMode: AutovalidateMode.onUnfocus,
                validator: (value) {
                  if (int.tryParse(value.toString().trim()) == null) {
                    return "Введите номер цифрой(ами)";
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Отмена"),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                final name = _fileNameController.text.trim();
                final description = _versionNumberController.text.trim();

                context.read<DocumentVersionUpdateBloc>().add(
                  DocumentVersionUpdate(
                    documentVersionId: widget.documentVersion.id,
                    verion: int.parse(_versionNumberController.text),
                    fileName: _fileNameController.text,
                  ),
                );
              }
            },
            child: Text("Обновить"),
          ),
        ],
      ),
    );
  }
}
