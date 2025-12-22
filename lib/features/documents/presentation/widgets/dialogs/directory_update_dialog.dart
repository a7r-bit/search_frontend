import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/dialog_bloc.dart';

class DirectoryUpdateDialog extends StatefulWidget {
  final Node directory;
  const DirectoryUpdateDialog({super.key, required this.directory});

  @override
  State<DirectoryUpdateDialog> createState() => _DirectoryUpdateDialogState();
}

class _DirectoryUpdateDialogState extends State<DirectoryUpdateDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.directory.name);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DialogBloc, DialogState>(
      listener: (context, state) {
        if (state is DialogDirectoryRenamed) {
          Navigator.pop(context, state.fileNode);
        }
      },
      child: AlertDialog.adaptive(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Обновление директории",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            // Text(
            //   "Создание дочерней директории для директории:\n${widget.lastDirectoryPAth.name}",
            //   style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            //     color: Theme.of(context).colorScheme.onSurfaceVariant,
            //   ),
            // ),
          ],
        ),

        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Название", style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: 2),
              TextFormField(
                controller: _nameController,
                autovalidateMode: AutovalidateMode.onUnfocus,
                validator: (value) {
                  if (value == widget.directory.name) {
                    return "Новое название не может совпадать со старым";
                  }
                  if (value == null || value.trim().isEmpty) {
                    return "Название обязательно";
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
                final name = _nameController.text.trim();
                context.read<DialogBloc>().add(
                  RenameDirectory(
                    directoryId: widget.directory.id,
                    name: name,
                    parentId: widget.directory.parentId,
                  ),
                );
              }
            },
            child: Text("Создать"),
          ),
        ],
      ),
    );
  }
}
