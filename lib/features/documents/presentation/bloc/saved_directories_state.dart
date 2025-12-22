part of 'saved_directories_bloc.dart';

@immutable
sealed class SavedDirectoriesState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SavedDirectoriesInitial extends SavedDirectoriesState {}

final class SavedDirectoriesLoading extends SavedDirectoriesState {}

final class SavedDirectoriesLoaded extends SavedDirectoriesState {
  final List<SavedDirectory> directories;

  SavedDirectoriesLoaded({required this.directories});

  @override
  List<Object?> get props => [directories];
}

final class SavedDirectoriesError extends SavedDirectoriesState {
  final Failure failure;

  SavedDirectoriesError({required this.failure});

  @override
  List<Object?> get props => [failure];
}
