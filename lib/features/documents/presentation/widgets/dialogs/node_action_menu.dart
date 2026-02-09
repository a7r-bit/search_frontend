import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/utils/injection.dart';
import 'package:search_frontend/core/widgets/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/index.dart';
import 'package:search_frontend/features/documents/presentation/cubit/node_sort_cubit.dart';
import 'package:search_frontend/features/documents/presentation/widgets/index.dart';

class NodeActionMenu extends StatelessWidget {
  final PathPart currentPath;
  final Node node;
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
        MenuItemButton(
          leadingIcon: Icon(
            isSaved ? Icons.star : Icons.star_border,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            context.read<SavedDirectoriesBloc>().add(
              ToggleSavedNodes(nodeId: node.id),
            );
          },
          child: Text(
            isSaved ? 'Удалить из избранного' : 'Добавить в избранное',
          ),
        ),
        MenuItemButton(
          leadingIcon: Icon(
            Icons.edit,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => BlocProvider(
                create: (context) => NodeBloc(repository: getIt()),
                child: NodeUpdateDialog(node: node),
              ),
            ).then(
              (value) => value is Node
                  ? {
                      context.read<NodeExplorerBloc>().add(
                        LoadChildren(
                          parentId: currentPath.id,
                          sortField: context
                              .read<NodeSortCubit>()
                              .state
                              .sortField,
                          sortOrder: context
                              .read<NodeSortCubit>()
                              .state
                              .sortOrder,
                        ),
                      ),
                      context.read<SavedDirectoriesBloc>().add(
                        LoadSavedDirectories(),
                      ),
                    }
                  : {},
            );
          },
          child: Text('Переименовать'),
        ),
        MenuItemButton(
          leadingIcon: Icon(
            Icons.delete_outline,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (dialogContext) {
                return BlocProvider.value(
                  value: context.read<NodeBloc>(),
                  child: WarningDialog(
                    title: node.type == NodeType.DIRECTORY
                        ? "Удаление директории"
                        : "Удаление документа",
                    description: node.type == NodeType.DIRECTORY
                        ? "При удалении директории все вложенные каталоги и документы также будут удалены"
                        : "Вы действительно хотите удалить этот документ?",
                    okFunction: () async {
                      context.read<NodeBloc>().add(DeleteNode(nodeId: node.id));

                      context.read<NodeExplorerBloc>().add(
                        LoadChildren(
                          parentId: currentPath.id,
                          sortField: context
                              .read<NodeSortCubit>()
                              .state
                              .sortField,
                          sortOrder: context
                              .read<NodeSortCubit>()
                              .state
                              .sortOrder,
                        ),
                      );

                      context.read<SavedDirectoriesBloc>().add(
                        LoadSavedDirectories(),
                      );
                    },
                  ),
                );
              },
            );
          },
          child: Text('Удалить'),
        ),
      ],
    );
  }
}
