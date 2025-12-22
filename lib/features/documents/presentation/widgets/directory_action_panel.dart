import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/utils/cubit/ui_state_cubit.dart';
import 'package:search_frontend/core/utils/cubit/ui_state_state.dart';
import 'package:search_frontend/core/utils/injection.dart';
import 'package:search_frontend/features/documents/presentation/bloc/dialog_bloc.dart';
import 'package:search_frontend/features/documents/presentation/bloc/directory_bloc.dart';

import '../../../../core/constants/index.dart';
import '../../../../core/domain/entities/index.dart';
import '../../../../core/utils/index.dart';
import 'index.dart';

class DirectoryActionPanel extends StatelessWidget {
  const DirectoryActionPanel({
    super.key,
    required this.uiState,
    required this.path,
  });
  final List<PathPart> path;
  final UIState uiState;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(child: DirectoryBreadcrumb(path: path)),
        Row(
          children: [
            SizedBox(width: 2),
            IconButton(
              onPressed: () => context.read<UiStateCubit>().toggleTableView(),

              icon: Icon(
                uiState.isTableView ? Icons.table_chart : Icons.grid_view,
              ),
            ),
            SizedBox(width: SizeConfig.blockSizeHorizontal),
            MenuAnchor(
              builder: (context, controller, child) => TextButton.icon(
                style: ButtonStyle(
                  visualDensity: VisualDensity.comfortable,
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(
                        AppRadius.small,
                      ),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.secondaryContainer,
                  ),
                ),
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                  } else {
                    controller.open();
                  }
                },
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
                        create: (context) => DialogBloc(repository: getIt()),
                        child: DirectoryCreateDialog(
                          lastDirectoryPAth: path.last,
                        ),
                      ),
                    ).then(
                      (value) => value is Node
                          ? context.read<DirectoryBloc>().add(
                              LoadChildren(parentId: path.last.id),
                            )
                          : {},
                    );
                  },
                ),
                PopupMenuDivider(height: 2),
                if (context.read<DirectoryBloc>().state is DirectoryLoaded &&
                    (context.read<DirectoryBloc>().state as DirectoryLoaded)
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
                          create: (context) => DialogBloc(repository: getIt()),
                          child: DocumentCreateDailog(
                            lastDirectoryPAth: path.last,
                          ),
                        ),
                      ).then(
                        (value) => value is Node
                            ? context.read<DirectoryBloc>().add(
                                LoadChildren(parentId: path.last.id),
                              )
                            : {},
                      );
                    },
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
