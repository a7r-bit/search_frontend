import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/domain/entities/index.dart';

class SearchBarListTile extends StatelessWidget {
  final SearchController controller;
  final FileNode node;
  const SearchBarListTile({
    super.key,
    required this.node,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        color: Theme.of(context).colorScheme.primary,
        node.type == "directory" ? Icons.folder : Icons.file_present_rounded,
      ),
      title: Text(node.name, style: Theme.of(context).textTheme.labelMedium),
      subtitle: node.description != null
          ? Text(
              node.description!,
              style: Theme.of(context).textTheme.bodySmall,
            )
          : null,

      onTap: () {
        node.type == "directory"
            ? context.goNamed(
                "directory",
                pathParameters: {"directoryId": node.id},
              )
            : context.goNamed(
                'documentDetails',
                pathParameters: {'directoryId': node.parentId!, 'id': node.id},
              );

        controller.closeView(node.name);
      },
    );
  }
}
