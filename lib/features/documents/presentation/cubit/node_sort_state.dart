part of 'node_sort_cubit.dart';

class NodeSortState extends Equatable {
  final SortField sortField;
  final SortOrder sortOrder;
  const NodeSortState({required this.sortField, required this.sortOrder});

  NodeSortState copyWith({SortField? sortField, SortOrder? sortOrder}) =>
      NodeSortState(
        sortField: sortField ?? this.sortField,
        sortOrder: sortOrder ?? this.sortOrder,
      );

  @override
  List<Object?> get props => [sortField, sortOrder];
}
