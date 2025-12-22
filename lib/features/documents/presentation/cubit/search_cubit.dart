import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/domain/entities/index.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/documents/domain/repositories/file_node_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final FileNodeRepository repository;
  SearchCubit({required this.repository}) : super(SearchInitial());

  Future<void> reset() async {
    emit(SearchInitial());
  }

  Future<void> search(String query) async {
    try {
      emit(SearchLoading());
      await Future.delayed(Duration(milliseconds: 200));
      final files = await repository.searchFile(query);
      emit(SearchLoaded(files: files));
    } on Failure catch (e) {
      addError(e);
      emit(SearchError(failure: e));
    }
  }
}
