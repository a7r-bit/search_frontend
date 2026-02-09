import 'package:search_frontend/core/errors/error_mapper.dart';
import 'package:search_frontend/features/documents/data/datasources/search_remote_data_source.dart';
import 'package:search_frontend/features/documents/data/models/search_result.dart';
import 'package:search_frontend/features/documents/domain/repositories/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final SearchDataSource remoteDataSource;

  SearchRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<SearchResultDTO>> globalSearch(
    String? currentNodeId,
    String searchQuery,
  ) async {
    try {
      final searchResults = await remoteDataSource.globalSearch(
        currentNodeId,
        searchQuery,
      );
      return searchResults;
    } on Exception catch (e) {
      throw mapExceptionToFailure(e);
    }
  }
}
