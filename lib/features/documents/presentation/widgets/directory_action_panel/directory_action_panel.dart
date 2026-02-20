import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/node_explorer_bloc.dart';
import 'index.dart';

class DirectoryActionPanel extends StatelessWidget {
  const DirectoryActionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeExplorerBloc, NodeExplorerState>(
      builder: (context, state) {
        if (state is NodeLoadLoading) {
          return SizedBox.shrink();
        }
        if (state is NodeLoadLoaded) {
          final path = state.path;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: DirectoryBreadcrumb()),
              Row(
                children: [
                  SizedBox(width: 2),
                  DirectorySortMenu(),
                  SizedBox(width: 2),
                  DirectoryViewToogle(),
                  SizedBox(width: 2),
                  DirectoryCreateMenu(path: path),
                ],
              ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
