import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/utils/injection.dart';
import 'package:search_frontend/core/widgets/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/index.dart';
import 'package:search_frontend/features/documents/presentation/cubit/node_sort_cubit.dart';
import 'package:search_frontend/features/documents/presentation/widgets/directory_action_panel/index.dart';
import 'package:search_frontend/features/documents/presentation/widgets/index.dart';

import 'node_move_dialog.dart';

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
    return BlocListener<NodeBloc, NodeState>(
      listener: (context, state) {
        if (state is NodeDeleted) {
          context.read<NodeExplorerBloc>().add(
            LoadChildren(
              parentId: currentPath.id,
              sortField: context.read<NodeSortCubit>().state.sortField,
              sortOrder: context.read<NodeSortCubit>().state.sortOrder,
            ),
          );
          context.read<SavedDirectoriesBloc>().add(LoadSavedDirectories());
        }
      },
      child: MenuAnchor(
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
              Icons.drive_file_move_outline,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            child: Text('Переместить'),
            onPressed: () async {
              final result = await showDialog<bool>(
                context: context,
                builder: (dialogContext) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (_) =>
                            NodeExplorerBloc(repository: getIt())..add(
                              LoadChildren(
                                parentId: node.parentId,
                                sortField: SortField.name,
                                sortOrder: SortOrder.asc,
                                nodeType: NodeType.DIRECTORY,
                              ),
                            ),
                      ),
                      BlocProvider(create: (_) => NodeSortCubit()),
                      BlocProvider.value(value: context.read<NodeBloc>()),
                      BlocProvider(
                        create: (_) =>
                            SavedDirectoriesBloc(repository: getIt()),
                      ),
                    ],
                    child: NodeMoveDialog(nodeId: node.id),
                  );
                },
              );

              if (result == true) {
                context.read<NodeExplorerBloc>().add(
                  LoadChildren(
                    parentId: currentPath.id,
                    sortField: context.read<NodeSortCubit>().state.sortField,
                    sortOrder: context.read<NodeSortCubit>().state.sortOrder,
                  ),
                );
                context.read<SavedDirectoriesBloc>().add(
                  LoadSavedDirectories(),
                );
              }
            },
          ),
          MenuItemButton(
            leadingIcon: Icon(
              Icons.mode_edit_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () async {
              final nodeBloc = context.read<NodeBloc>();

              final result = await showDialog(
                context: context,
                builder: (context) => BlocProvider.value(
                  value: nodeBloc,
                  child: NodeUpdateDialog(node: node),
                ),
              );
              if (result is Node) {
                context.read<NodeExplorerBloc>().add(
                  LoadChildren(
                    parentId: currentPath.id,
                    sortField: context.read<NodeSortCubit>().state.sortField,
                    sortOrder: context.read<NodeSortCubit>().state.sortOrder,
                  ),
                );
                context.read<SavedDirectoriesBloc>().add(
                  LoadSavedDirectories(),
                );
              }
            },
            child: Text('Переименовать'),
          ),
          MenuItemButton(
            leadingIcon: Icon(
              Icons.delete_outline,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
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
                    ),
                  );
                },
              );
              if (confirmed == true) {
                context.read<NodeBloc>().add(DeleteNode(nodeId: node.id));
              }
            },
            child: Text('Удалить'),
          ),
        ],
      ),
    );
  }
}
