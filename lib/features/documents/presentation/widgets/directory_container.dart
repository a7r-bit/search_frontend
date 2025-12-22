import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/utils/cubit/ui_state_cubit.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/directory_bloc.dart';
import 'package:search_frontend/features/documents/presentation/widgets/directory_card_view.dart';
import 'package:search_frontend/features/documents/presentation/widgets/index.dart';

import 'directory_action_panel.dart';

class DirectoryContainer extends StatelessWidget {
  const DirectoryContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<DirectoryBloc, DirectoryState>(
        builder: (context, state) {
          if (state is DirectoryLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is DirectoryLoaded) {
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
