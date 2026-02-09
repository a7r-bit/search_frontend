import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/node_bloc.dart';

class NodeUpdateDialog extends StatefulWidget {
  final Node node;

  const NodeUpdateDialog({super.key, required this.node});

  @override
  State<NodeUpdateDialog> createState() => _NodeUpdateDialogState();
}

class _NodeUpdateDialogState extends State<NodeUpdateDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.node.name);
    _descriptionController = TextEditingController(
      text: widget.node.description,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDirectory = widget.node.type == NodeType.DIRECTORY;
    final titleText = isDirectory
        ? "Обновление директории"
        : "Обновление документа";

    return BlocListener<NodeBloc, NodeState>(
      listener: (context, state) {
        if (state is NodeUpdated) {
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
                  // if (value == widget.node.name) {
                  //   return "Новое название не может совпадать со старым";
                  // }
                  if (value == null || value.trim().isEmpty) {
                    return "Название обязательно";
                  }
                  return null;
                },
              ),
              Text("Описание", style: Theme.of(context).textTheme.bodySmall),
              SizedBox(height: 2),
              TextFormField(
                controller: _descriptionController,
                autovalidateMode: AutovalidateMode.onUnfocus,
                validator: (value) {
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
                context.read<NodeBloc>().add(
                  UpdateNode(
                    name: _nameController.text.trim(),
                    description: _descriptionController.text.trim(),
                    nodeId: widget.node.id,
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
