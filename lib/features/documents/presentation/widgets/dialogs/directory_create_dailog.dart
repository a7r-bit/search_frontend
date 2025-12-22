import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/dialog_bloc.dart';

class DirectoryCreateDialog extends StatefulWidget {
  final PathPart lastDirectoryPAth;
  const DirectoryCreateDialog({super.key, required this.lastDirectoryPAth});

  @override
  State<DirectoryCreateDialog> createState() => _DirectoryCreateDialogState();
}

class _DirectoryCreateDialogState extends State<DirectoryCreateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<DialogBloc, DialogState>(
      listener: (context, state) {
        if (state is DialogLoaded) {
          Navigator.pop(
            context,
            state.fileNode,
          ); // закрываем диалог и возвращаем созданную директорию
        }
      },
      child: AlertDialog.adaptive(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Создание директории",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              "Создание дочерней директории для директории:\n${widget.lastDirectoryPAth.name}",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
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
              Text("Название", style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: 2),
              TextFormField(
                controller: _nameController,
                autovalidateMode: AutovalidateMode.onUnfocus,
                validator: (value) {
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
                  CreateDirectory(
                    name: name,
                    parentId: widget.lastDirectoryPAth.id,
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
