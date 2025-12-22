import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/domain/entities/file_node.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/utils/injection.dart';
import 'package:search_frontend/core/widgets/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/dialog_bloc.dart';
import 'package:search_frontend/features/documents/presentation/bloc/index.dart';
import 'package:search_frontend/features/documents/presentation/widgets/index.dart';

class NodeActionMenu extends StatelessWidget {
  final PathPart currentPath;
  final FileNode node;
  final bool isSaved;

  const NodeActionMenu({
    super.key,
    required this.node,
    required this.isSaved,
    required this.currentPath,
  });

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          icon: const Icon(Icons.more_vert, size: 18),
          padding: EdgeInsets.zero,
          onPressed: () {
            controller.open();
          },
        );
      },
      menuChildren: [
        if (node.type == "directory")
          MenuItemButton(
            leadingIcon: Icon(
              isSaved ? Icons.star : Icons.star_border,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {
              context.read<SavedDirectoriesBloc>().add(
                ToggleSavedDirectories(directoryId: node.id),
              );
            },
            child: Text(
              isSaved ? 'Удалить из избранного' : 'Добавить в избранное',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        const PopupMenuDivider(height: 2),
        MenuItemButton(
          leadingIcon: Icon(
            Icons.edit,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => BlocProvider(
                create: (context) => DialogBloc(repository: getIt()),
                child: node.type == "directory"
                    ? DirectoryUpdateDialog(directory: node)
                    : DocumentUpdateDialog(document: node),
              ),
            ).then(
              (value) => value is FileNode
                  ? {
                      context.read<DirectoryBloc>().add(
                        LoadChildren(parentId: currentPath.id),
                      ),
                      context.read<SavedDirectoriesBloc>().add(
                        LoadSavedDirectories(),
                      ),
                    }
                  : {},
            );
          },
          child: Text(
            'Переименовать',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        const PopupMenuDivider(height: 2),
        MenuItemButton(
          leadingIcon: Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return BlocProvider.value(
                  value: context.read<DirectoryBloc>(),
                  child: Builder(
                    builder: (innerContext) => WarningDialog(
                      title: node.type == "directory"
                          ? "Удаление директории"
                          : "Удаление документа",
                      description: node.type == "directory"
                          ? "При удалении директории все вложенные каталоги и документы также будут удалены"
                          : "Вы действительно хотите удалить этот документ?",
                      okFunction: () async {
                        final bloc = innerContext.read<DirectoryBloc>();
                        if (node.type == "directory") {
                          bloc.add(
                            DeleteDirectory(
                              directoryId: node.id,
                              parentId: node.parentId,
                            ),
                          );
                        } else {
                          bloc.add(
                            DeleteDocument(
                              documentId: node.id,
                              parentId: node.parentId,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                );
              },
            );
          },
          child: Text('Удалить', style: Theme.of(context).textTheme.labelSmall),
        ),
      ],
    );
  }
}
