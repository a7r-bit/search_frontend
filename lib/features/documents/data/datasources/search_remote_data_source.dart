import 'package:search_frontend/features/documents/data/models/search_result.dart';

import '../../../../core/utils/index.dart';

abstract class SearchDataSource {
  Future<List<SearchResultDTO>> globalSearch(
    String? currentNodeId,
    String searchQuery,
  );
}

class SearchRemoteDataSourceImpl implements SearchDataSource {
  final ApiClient _apiClient;

  SearchRemoteDataSourceImpl({required ApiClient apiClient})
    : _apiClient = apiClient;

  @override
  Future<List<SearchResultDTO>> globalSearch(
    String? currentNodeId,
    String searchQuery,
  ) async {
    final response = await _apiClient.post(
      "/global-search",
      data: {
        "currentNodeId": currentNodeId ?? null,
        "searchQuery": searchQuery,
      },
    );

    return (response as List<dynamic>)
        .map((e) => searchResultFromJson(e as Map<String, dynamic>))
        .toList();
  }
}
