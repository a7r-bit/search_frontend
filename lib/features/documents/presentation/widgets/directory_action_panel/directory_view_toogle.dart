import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/cubit/ui_state_cubit.dart';
import '../../../../../core/utils/cubit/ui_state_state.dart';

class DirectoryViewToogle extends StatelessWidget {
  const DirectoryViewToogle({super.key, required this.uiState});

  final UIState uiState;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<UiStateCubit>().toggleTableView(),

      icon: Icon(
        uiState.isTableView
            ? Icons.table_chart_outlined
            : Icons.grid_view_outlined,
      ),
    );
  }
}
