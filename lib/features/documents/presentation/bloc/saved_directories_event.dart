part of 'saved_directories_bloc.dart';

@immutable
sealed class SavedDirectoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Загрузка сохранененных директорий
class LoadSavedDirectories extends SavedDirectoriesEvent {}

// Сохранить/Удалить директорию
class ToggleSavedDirectories extends SavedDirectoriesEvent {
  final String directoryId;

  ToggleSavedDirectories({required this.directoryId});

  @override
  List<Object?> get props => [directoryId];
}
