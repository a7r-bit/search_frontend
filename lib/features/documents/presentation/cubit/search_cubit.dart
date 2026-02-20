import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:search_frontend/core/domain/failures/failure.dart';
import 'package:search_frontend/features/documents/domain/repositories/search_repository.dart';

import '../../data/models/search_result.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository repository;
  int _requestId = 0;

  SearchCubit({required this.repository}) : super(SearchInitial());

  void reset() {
    emit(SearchInitial());
  }

  Future<void> search({
    required String? currentNodeId,
    required String searchQuery,
  }) async {
    final int requestId = ++_requestId;
    try {
      emit(SearchLoading());
      final files = await repository.globalSearch(currentNodeId, searchQuery);

      if (requestId != _requestId) return;
      emit(SearchLoaded(searchResults: files));
    } on Failure catch (e) {
      addError(e);
      emit(SearchError(failure: e));
    }
  }
}
