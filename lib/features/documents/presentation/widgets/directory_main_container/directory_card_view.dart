import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/core/widgets/extention/node_type_icons.dart';
import 'package:search_frontend/features/documents/presentation/bloc/saved_directories_bloc.dart';
import 'package:search_frontend/features/documents/presentation/widgets/index.dart';

class DirectoryCardView extends StatelessWidget {
  final PathPart currenPath;
  final List<Node> children;
  const DirectoryCardView({
    super.key,
    required this.children,
    required this.currenPath,
  });

  @override
  Widget build(BuildContext context) {
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
        return DirectoryCard(node: children[index], currentPath: currenPath);
      },
    );
  }
}

class DirectoryCard extends StatefulWidget {
  final Node node;
  final PathPart currentPath;
  const DirectoryCard({
    super.key,
    required this.node,
    required this.currentPath,
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

        onHover: (value) => setState(() => isHovered = value),

        onTap: () async {
          switch (widget.node.type) {
            case NodeType.DIRECTORY:
              context.goNamed(
                "node",
                pathParameters: {"nodeId": widget.node.id},
              );
            case NodeType.DOCUMENT:
              context.goNamed(
                'documentDetails',
                pathParameters: {
                  'nodeId': widget.currentPath.id!,
                  'id': widget.node.id,
                },
              );
          }
        },
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
                        BlocBuilder<
                          SavedDirectoriesBloc,
                          SavedDirectoriesState
                        >(
                          builder: (context, state) {
                            bool isSaved = false;
                            if (state is SavedDirectoriesLoaded) {
                              isSaved = state.directories.any(
                                (d) => d.id == widget.node.id,
                              );
                            }
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
}
