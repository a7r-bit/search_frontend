import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:go_router/go_router.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/entities/path_part.dart';

import '../../bloc/node_explorer_bloc.dart';
import 'directory_sort_menu.dart';

class DirectoryBreadcrumb extends StatelessWidget {
  final DirectoryViewMode mode;

  const DirectoryBreadcrumb({
    super.key,
    this.mode = DirectoryViewMode.navigation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeExplorerBloc, NodeExplorerState>(
      builder: (context, state) {
        if (state is NodeLoadLoading) {
          return SizedBox.shrink();
        }
        if (state is NodeLoadLoaded) {
          final path = state.path;
          return BreadCrumb(
            overflow: ScrollableOverflow(),
            items: path.map((part) {
              return BreadCrumbItem(
                textColor: Theme.of(context).colorScheme.onSurface,

                borderRadius: BorderRadiusGeometry.circular(AppRadius.small),
                content: Text(
                  part.name,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: path.last == part
                        ? Theme.of(context).colorScheme.onSurfaceVariant
                        : Theme.of(context).colorScheme.onSurface,
                    fontWeight: path.last == part
                        ? FontWeight.w600
                        : FontWeight.w300,
                  ),
                ),
                onTap: mode == DirectoryViewMode.navigation
                    ? () => context.goNamed(
                        "node",
                        pathParameters: {"nodeId": part.id ?? "root"},
                      )
                    : () {
                        context.read<NodeExplorerBloc>().add(
                          LoadChildren(
                            parentId: part.id,
                            sortField: SortField.name,
                            sortOrder: SortOrder.asc,
                            nodeType: NodeType.DIRECTORY,
                          ),
                        );
                      },
              );
            }).toList(),
            divider: Icon(Icons.chevron_right, size: 16, color: Colors.grey),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
