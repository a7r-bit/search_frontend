import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/documents/domain/repositories/search_repository.dart';

import '../../data/models/search_result.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repository;
  SearchCubit({required this.repository}) : super(SearchInitial());

  Future<void> reset() async {
    emit(SearchInitial());
  }

  Future<void> search({
    required String? currentNodeId,
    required String searchQuery,
  }) async {
    try {
      emit(SearchLoading());
      final files = await repository.globalSearch(currentNodeId, searchQuery);
      emit(SearchLoaded(searchResults: files));
    } on Failure catch (e) {
      addError(e);
      emit(SearchError(failure: e));
    }
  }
}
