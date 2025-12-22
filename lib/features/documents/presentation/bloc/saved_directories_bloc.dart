import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/documents/domain/repositories/saved_directory_repository.dart';

part 'saved_directories_event.dart';
part 'saved_directories_state.dart';

class SavedDirectoriesBloc
    extends Bloc<SavedDirectoriesEvent, SavedDirectoriesState> {
  final SavedDirectoryRepository repository;
  SavedDirectoriesBloc({required this.repository})
    : super(SavedDirectoriesInitial()) {
    on<LoadSavedDirectories>(_onLoadSavedDirectories);
    on<ToggleSavedDirectories>(_onToggleSavedDirectories);
  }

  Future<void> _onLoadSavedDirectories(
    LoadSavedDirectories event,
    Emitter<SavedDirectoriesState> emit,
  ) async {
    final previousState = state;
    emit(SavedDirectoriesLoading());
    try {
      final directories = await repository.getSavedDirectories();
      emit(SavedDirectoriesLoaded(directories: directories));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }

  Future<void> _onToggleSavedDirectories(
    ToggleSavedDirectories event,
    Emitter<SavedDirectoriesState> emit,
  ) async {
    final previousState = state;
    emit(SavedDirectoriesLoading());
    try {
      await repository.toggleSavedDirectory(directoryId: event.directoryId);

      final directories = await repository.getSavedDirectories();
      emit(SavedDirectoriesLoaded(directories: directories));
    } on Failure catch (e) {
      addError(e);
      emit(previousState);
    }
  }
}
