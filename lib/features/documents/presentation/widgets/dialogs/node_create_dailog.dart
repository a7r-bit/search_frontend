import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/node_bloc.dart';

import '../../../../../core/constants/index.dart';

class NodeCreateDialog extends StatefulWidget {
  final PathPart lastDirectoryPath;
  final NodeType nodeType;
  const NodeCreateDialog({
    super.key,
    required this.lastDirectoryPath,
    required this.nodeType,
  });

  @override
  State<NodeCreateDialog> createState() => _NodeCreateDialogState();
}

class _NodeCreateDialogState extends State<NodeCreateDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final width = Responsive.dialogWidth(context);

    final isDirectory = widget.nodeType == NodeType.DIRECTORY;
    final titleText = isDirectory
        ? "Создание директории"
        : "Создание документа";
    final subText = isDirectory
        ? "Создание дочерней директории для:\n${widget.lastDirectoryPath.name}"
        : "Создание документа в директории:\n${widget.lastDirectoryPath.name}";

    return BlocListener<NodeBloc, NodeState>(
      listener: (context, state) {
        if (state is NodeLoaded) {
          Navigator.pop(context, state.node);
        }
      },
      child: AlertDialog.adaptive(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            Text(
              subText,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),

        content: SizedBox(
          width: width,
          child: Form(
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
                SizedBox(height: AppPadding.extraSmall),
                Text("Описание", style: Theme.of(context).textTheme.bodySmall),
                SizedBox(height: 2),
                TextFormField(
                  controller: _descriptionController,
                  autovalidateMode: AutovalidateMode.onUnfocus,
                ),
              ],
            ),
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
                context.read<NodeBloc>().add(
                  CreateNode(
                    name: _nameController.text.trim(),
                    parentId: widget.lastDirectoryPath.id,
                    description: _descriptionController.text.trim(),
                    type: widget.nodeType,
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
