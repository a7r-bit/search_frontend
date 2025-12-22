part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchLoaded extends SearchState {
  final List<FileNode> files;

  const SearchLoaded({required this.files});

  @override
  List<Object> get props => [files];
}

final class SearchError extends SearchState {
  final Failure failure;

  const SearchError({required this.failure});

  @override
  List<Object> get props => [failure];
}
