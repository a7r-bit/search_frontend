import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/features/documents/presentation/cubit/node_sort_cubit.dart';

enum SortField { type, name, createdAt, updatedAt }

enum SortOrder { asc, desc }

class DirectorySortMenu extends StatelessWidget {
  const DirectorySortMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NodeSortCubit, NodeSortState>(
      builder: (context, state) {
        return MenuAnchor(
          builder: (context, controller, child) => IconButton(
            onPressed: () =>
                controller.isOpen ? controller.close() : controller.open(),
            icon: Icon(Icons.filter_list),
          ),
          menuChildren: [
            RadioMenuButton(
              value: SortField.type,
              groupValue: state.sortField,
              onChanged: (value) {
                if (value == null) return;
                context.read<NodeSortCubit>().setField(value);
              },
              child: Text("Type"),
            ),
            RadioMenuButton(
              value: SortField.name,
              groupValue: state.sortField,
              onChanged: (value) {
                if (value == null) return;
                context.read<NodeSortCubit>().setField(value);
              },
              child: Text("Name"),
            ),
            RadioMenuButton(
              value: SortField.createdAt,
              groupValue: state.sortField,
              onChanged: (value) {
                if (value == null) return;
                context.read<NodeSortCubit>().setField(value);
              },
              child: Text("CreatedAt"),
            ),
            RadioMenuButton(
              value: SortField.updatedAt,

              groupValue: state.sortField,
              onChanged: (value) {
                if (value == null) return;
                context.read<NodeSortCubit>().setField(value);
              },
              child: Text("UpdatedAt"),
            ),

            PopupMenuDivider(height: 2),

            RadioMenuButton(
              value: SortOrder.asc,
              groupValue: state.sortOrder,
              onChanged: (value) {
                if (value == null) return;
                context.read<NodeSortCubit>().setOrder(value);
              },
              child: Text("Ascending"),
            ),
            RadioMenuButton(
              value: SortOrder.desc,
              groupValue: state.sortOrder,
              onChanged: (value) {
                if (value == null) return;
                context.read<NodeSortCubit>().setOrder(value);
              },
              child: Text("Descending"),
            ),
          ],
        );
      },
    );
  }
}
