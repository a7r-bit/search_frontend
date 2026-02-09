import 'package:flutter/material.dart';
import 'package:search_frontend/core/utils/cubit/ui_state_state.dart';
import '../../../../../core/domain/entities/index.dart';
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
            DirectorySortMenu(),
            SizedBox(width: 2),
            DirectoryViewToogle(uiState: uiState),
            SizedBox(width: 2),
            DirectoryCreateMenu(path: path),
          ],
        ),
      ],
    );
  }
}
