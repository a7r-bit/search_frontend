import 'package:search_frontend/features/documents/data/models/search_result.dart';

import '../../../../core/domain/entities/node.dart';

abstract class SearchRepository {
  Future<List<SearchResultDTO>> globalSearch(
    String? currentNodeId,
    String searchQuery,
  );
}
