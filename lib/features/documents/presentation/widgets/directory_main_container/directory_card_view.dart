import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/index.dart';
import 'package:search_frontend/features/documents/presentation/widgets/directory_action_panel/directory_sort_menu.dart';
import 'package:search_frontend/features/documents/presentation/widgets/index.dart';

class DirectoryCardView extends StatelessWidget {
  const DirectoryCardView({
    super.key,
    this.showActions = true,
    this.mode = DirectoryViewMode.navigation,
  });

  final bool showActions;
  final DirectoryViewMode mode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeExplorerBloc, NodeExplorerState>(
      builder: (context, state) {
        if (state is NodeLoadLoading) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is NodeLoadLoaded) {
          final children = state.children;
          final currenPath = state.path.last;
          if (children.isEmpty) {
            return Center(
              child: Text(
                "Нет элементов",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          return GridView.builder(
            shrinkWrap: true,

            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: Responsive.isDesktop(context)
                  ? 7
                  : Responsive.isTablet(context)
                  ? 6
                  : 3,

              crossAxisSpacing: AppPadding.small,
              mainAxisSpacing: AppPadding.small,
              childAspectRatio: 3.5 / 3.5,
            ),
            itemCount: children.length,
            itemBuilder: (context, index) {
              return DirectoryCard(
                node: children[index],
                currentPath: currenPath,
                showActions: showActions,
                onTap: mode == DirectoryViewMode.navigation
                    ? null
                    : () {
                        context.read<NodeExplorerBloc>().add(
                          LoadChildren(
                            parentId: children[index].id,
                            sortField: SortField.name,
                            sortOrder: SortOrder.asc,
                            nodeType: NodeType.DIRECTORY,
                          ),
                        );
                      },
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class DirectoryCard extends StatefulWidget {
  final Node node;
  final PathPart currentPath;
  final bool showActions;
  final VoidCallback? onTap;
  const DirectoryCard({
    super.key,
    required this.node,
    required this.currentPath,
    this.showActions = true,
    this.onTap,
  });

  @override
  State<DirectoryCard> createState() => _DirectoryCardState();
}

class _DirectoryCardState extends State<DirectoryCard> {
  bool isFocused = false;
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(AppRadius.small),

      child: InkWell(
        onFocusChange: (isFocused) =>
            setState(() => this.isFocused = isFocused),

        onHover: (value) => setState(() => this.isHovered = value),

        onTap: widget.onTap ?? _defaultOnTap,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: isFocused == true || isHovered == true
                      ? Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.5)
                      : Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.2),
                ),

                borderRadius: BorderRadius.circular(AppRadius.small),
              ),
              width: constraints.maxWidth,
              height: constraints.maxWidth,
              child: Stack(
                children: [
                  Center(
                    child: Icon(
                      widget.node.type.icon,
                      size: constraints.maxWidth * 0.35,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: AppPadding.extraSmall),
                        Text(
                          widget.node.name,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          // textAlign: TextAlign.start,
                        ),

                        Text(
                          dateFormatter.format(widget.node.createdAt),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(fontSize: 11, color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          // textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),

                  if (widget.showActions)
                    Positioned(
                      top: Responsive.of(
                        context: context,
                        mobile: 0,
                        tablet: 5,
                        desktop: 5,
                      ),
                      right: Responsive.of(
                        context: context,
                        mobile: 0,
                        tablet: 5,
                        desktop: 5,
                      ),
                      child:
                          BlocSelector<
                            SavedDirectoriesBloc,
                            SavedDirectoriesState,
                            bool
                          >(
                            selector: (state) {
                              if (state is SavedDirectoriesLoaded) {
                                return state.directories.any(
                                  (d) => d.id == widget.node.id,
                                );
                              }
                              return false;
                            },
                            builder: (context, isSaved) {
                              return NodeActionMenu(
                                currentPath: widget.currentPath,
                                node: widget.node,
                                isSaved: isSaved,
                              );
                            },
                          ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _defaultOnTap() {
    switch (widget.node.type) {
      case NodeType.DIRECTORY:
        context.goNamed("node", pathParameters: {"nodeId": widget.node.id});
        break;
      case NodeType.DOCUMENT:
        context.goNamed(
          'documentDetails',
          pathParameters: {
            'nodeId': widget.currentPath.id!,
            'id': widget.node.id,
          },
        );
        break;
    }
  }
}
