part of 'directory_bloc.dart';

sealed class DirectoryState extends Equatable {
  const DirectoryState();

  @override
  List<Object?> get props => [];
}

final class DirectoryInitial extends DirectoryState {}

final class DirectoryLoading extends DirectoryState {}

final class DirectoryLoaded extends DirectoryState {
  final List<FileNode> children;
  final List<PathPart> path;

  const DirectoryLoaded({required this.children, required this.path});

  @override
  List<Object?> get props => [children, path];
}

final class DirectoryError extends DirectoryState {
  final Failure failure;

  const DirectoryError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
