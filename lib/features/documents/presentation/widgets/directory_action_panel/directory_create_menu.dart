import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/features/documents/presentation/bloc/node_bloc.dart';
import 'package:search_frontend/features/documents/presentation/bloc/node_explorer_bloc.dart';
import 'package:search_frontend/features/documents/presentation/cubit/node_sort_cubit.dart';
import 'package:search_frontend/features/documents/presentation/widgets/dialogs/node_create_dailog.dart';

import '../../../../../core/constants/index.dart';
import '../../../../../core/domain/entities/index.dart';
import '../../../../../core/utils/injection.dart';

class DirectoryCreateMenu extends StatelessWidget {
  const DirectoryCreateMenu({super.key, required this.path});

  final List<PathPart> path;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) => TextButton.icon(
        style: ButtonStyle(
          visualDensity: VisualDensity.comfortable,
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(AppRadius.small),
            ),
          ),
          backgroundColor: WidgetStatePropertyAll(
            Theme.of(context).colorScheme.secondaryContainer,
          ),
        ),
        onPressed: () =>
            controller.isOpen ? controller.close() : controller.open(),
        label: Text("Добавить"),
        icon: Icon(Icons.add),
      ),
      menuChildren: [
        MenuItemButton(
          leadingIcon: Icon(
            Icons.folder,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          child: Text(
            "Директория",
            style: Theme.of(context).textTheme.labelSmall,
          ),

          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => BlocProvider(
                create: (context) => NodeBloc(repository: getIt()),
                child: NodeCreateDialog(
                  lastDirectoryPath: path.last,
                  nodeType: NodeType.DIRECTORY,
                ),
              ),
            ).then(
              (value) => value is Node
                  ? context.read<NodeExplorerBloc>().add(
                      LoadChildren(
                        parentId: path.last.id,
                        sortField: context
                            .read<NodeSortCubit>()
                            .state
                            .sortField,
                        sortOrder: context
                            .read<NodeSortCubit>()
                            .state
                            .sortOrder,
                      ),
                    )
                  : {},
            );
          },
        ),
        if (context.read<NodeExplorerBloc>().state is NodeLoadLoaded &&
            (context.read<NodeExplorerBloc>().state as NodeLoadLoaded)
                    .path
                    .last
                    .id !=
                null)
          PopupMenuDivider(height: 2),
        if (context.read<NodeExplorerBloc>().state is NodeLoadLoaded &&
            (context.read<NodeExplorerBloc>().state as NodeLoadLoaded)
                    .path
                    .last
                    .id !=
                null)
          MenuItemButton(
            leadingIcon: Icon(
              Icons.file_present_rounded,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            child: Text(
              "Документ",
              style: Theme.of(context).textTheme.labelSmall,
            ),

            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => BlocProvider(
                  create: (context) => NodeBloc(repository: getIt()),
                  child: NodeCreateDialog(
                    lastDirectoryPath: path.last,
                    nodeType: NodeType.DOCUMENT,
                  ),
                ),
              ).then(
                (value) => value is Node
                    ? context.read<NodeExplorerBloc>().add(
                        LoadChildren(
                          parentId: path.last.id,
                          sortField: context
                              .read<NodeSortCubit>()
                              .state
                              .sortField,
                          sortOrder: context
                              .read<NodeSortCubit>()
                              .state
                              .sortOrder,
                        ),
                      )
                    : {},
              );
            },
          ),
      ],
    );
  }
}
