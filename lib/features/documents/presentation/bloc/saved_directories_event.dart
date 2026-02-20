part of 'saved_directories_bloc.dart';

@immutable
sealed class SavedDirectoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Загрузка сохранененных директорий
class LoadSavedDirectories extends SavedDirectoriesEvent {}

// Сохранить/Удалить директорию
class ToggleSavedNodes extends SavedDirectoriesEvent {
  final String nodeId;

  ToggleSavedNodes({required this.nodeId});

  @override
  List<Object?> get props => [nodeId];
}
