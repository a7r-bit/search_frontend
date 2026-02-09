import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/core/widgets/extention/node_type_icons.dart';
import 'package:search_frontend/features/documents/presentation/bloc/saved_directories_bloc.dart';

import '../../bloc/index.dart';

class SavedDirectoryCard extends StatefulWidget {
  final Node node;

  const SavedDirectoryCard({super.key, required this.node});

  @override
  State<SavedDirectoryCard> createState() => _SavedDirectoryCardState();
}

class _SavedDirectoryCardState extends State<SavedDirectoryCard> {
  bool isFocused = false;
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Material(
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
                          'nodeId': widget.node.parentId!,
                          'id': widget.node.id,
                        },
                      );
                  }
                },
                child: Container(
                  width: 270,
                  height: 80,
                  padding: const EdgeInsets.all(AppPadding.small),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.small),
                    border: Border.all(
                      color: isFocused == true || isHovered == true
                          ? Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.5)
                          : Theme.of(
                              context,
                            ).colorScheme.outline.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 25,
                        child: Icon(
                          widget.node.type.icon,
                          size: 35,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.node.name,
                              style: Theme.of(context).textTheme.labelLarge!
                                  .copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            ),
                            Text(
                              widget.node.description ?? "",
                              style: Theme.of(context).textTheme.labelMedium
                                  ?.copyWith(fontSize: 11, color: Colors.grey),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () => context.read<SavedDirectoriesBloc>().add(
                  ToggleSavedNodes(nodeId: widget.node.id),
                ),
                icon: Icon(
                  Icons.star,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
