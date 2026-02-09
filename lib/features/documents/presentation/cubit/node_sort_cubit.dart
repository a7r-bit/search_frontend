import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/features/documents/presentation/widgets/directory_action_panel/index.dart';

part 'node_sort_state.dart';

class NodeSortCubit extends Cubit<NodeSortState> {
  NodeSortCubit()
    : super(NodeSortState(sortField: SortField.name, sortOrder: SortOrder.asc));
  void setField(SortField field) => emit(state.copyWith(sortField: field));
  void setOrder(SortOrder order) => emit(state.copyWith(sortOrder: order));
}
