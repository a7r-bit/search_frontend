import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/node_bloc.dart';
import 'package:search_frontend/features/documents/presentation/bloc/node_explorer_bloc.dart';
import 'package:search_frontend/features/documents/presentation/bloc/saved_directories_bloc.dart';
import 'package:search_frontend/features/documents/presentation/cubit/node_sort_cubit.dart';
import 'package:search_frontend/features/documents/presentation/widgets/index.dart';
import 'package:search_frontend/features/documents/presentation/widgets/directory_main_container/directory_container.dart';

import '../../../../core/utils/injection.dart';

class DocumentsPage extends StatelessWidget {
  final String? nodeId;
  const DocumentsPage({super.key, this.nodeId});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<NodeBloc>(create: (_) => NodeBloc(repository: getIt())),
        BlocProvider<SavedDirectoriesBloc>(
          create: (_) =>
              getIt<SavedDirectoriesBloc>()..add(LoadSavedDirectories()),
        ),
        BlocProvider<NodeExplorerBloc>(
          create: (_) => getIt<NodeExplorerBloc>(),
        ),
      ],
      child: BlocListener<NodeSortCubit, NodeSortState>(
        listenWhen: (prev, curr) => prev != curr,

        listener: (context, state) {
          context.read<NodeExplorerBloc>().add(
            LoadChildren(
              parentId: nodeId,
              sortField: state.sortField,
              sortOrder: state.sortOrder,
            ),
          );
        },
        child: Builder(
          builder: (context) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final sort = context.read<NodeSortCubit>().state;

              context.read<NodeExplorerBloc>().add(
                LoadChildren(
                  parentId: nodeId,
                  sortField: sort.sortField,
                  sortOrder: sort.sortOrder,
                ),
              );
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (!Responsive.isDesktop(context))
                  SizedBox(
                    width: double.infinity,
                    child: SearchWidget(currentNodeId: nodeId),
                  ),
                if (!Responsive.isDesktop(context))
                  SizedBox(height: SizeConfig.blockSizeVertical),
                QuickAccessContainer(),
                SizedBox(height: SizeConfig.blockSizeVertical),
                Expanded(child: DirectoryContainer()),
              ],
            );
          },
        ),
      ),
    );
  }
}
