import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/utils/cubit/ui_state_cubit.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/node_explorer_bloc.dart';
import 'package:search_frontend/features/documents/presentation/widgets/directory_main_container/directory_card_view.dart';
import 'package:search_frontend/features/documents/presentation/widgets/index.dart';

import '../directory_action_panel/directory_action_panel.dart';

class DirectoryContainer extends StatelessWidget {
  const DirectoryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<NodeExplorerBloc, NodeExplorerState>(
        builder: (context, state) {
          if (state is NodeLoadLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is NodeLoadLoaded) {
            final uiState = context.watch<UiStateCubit>().state;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DirectoryActionPanel(uiState: uiState, path: state.path),
                SizedBox(height: SizeConfig.blockSizeVertical),

                Expanded(
                  child: uiState.isTableView
                      ? DirectoryCardView(
                          children: state.children,
                          currenPath: state.path.last,
                        )
                      : DirectoryTableView(
                          children: state.children,
                          currenPath: state.path.last,
                        ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
