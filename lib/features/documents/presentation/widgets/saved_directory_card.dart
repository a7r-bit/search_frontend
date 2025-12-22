import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/saved_directories_bloc.dart';

import '../bloc/index.dart';

class SavedDirectoryCard extends StatefulWidget {
  final SavedDirectory directory;

  const SavedDirectoryCard({super.key, required this.directory});

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
        return Tooltip(
          message:
              "${widget.directory.name}\nДиректории: ${widget.directory.childrenCount} | Документы: ${widget.directory.documentCount}",
          preferBelow: true,
          verticalOffset: 35,
          child: Stack(
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
                    context.goNamed(
                      "directory",
                      pathParameters: {"directoryId": widget.directory.id},
                    );
                    // context.read<DirectoryBloc>().add(
                    //   LoadChildren(parentId: widget.directory.id),
                    // );
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
                            Icons.folder,
                            size: 35,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: SizeConfig.blockSizeHorizontal),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.directory.name,
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                              ),
                              // SizedBox(height: SizeConfig.blockSizeVertical),
                              Row(
                                children: [
                                  Text(
                                    "Директории: ${widget.directory.childrenCount}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                  SizedBox(
                                    width: SizeConfig.blockSizeHorizontal,
                                  ),
                                  Text(
                                    "Документы: ${widget.directory.documentCount}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall!
                                        .copyWith(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurfaceVariant,
                                        ),
                                  ),
                                ],
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
                    ToggleSavedDirectories(directoryId: widget.directory.id),
                  ),
                  icon: Icon(
                    Icons.star,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
