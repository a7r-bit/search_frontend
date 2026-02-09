import 'package:json_annotation/json_annotation.dart';

import 'search_result.dart';

class ElasticIndexConverter implements JsonConverter<ElasticIndex, String> {
  const ElasticIndexConverter();

  @override
  ElasticIndex fromJson(String json) {
    switch (json) {
      case 'nodes':
        return ElasticIndex.nodes;
      case 'document_versions':
        return ElasticIndex.documentVersions;
      default:
        throw ArgumentError('Unknown ElasticIndex: $json');
    }
  }

  @override
  String toJson(ElasticIndex object) {
    switch (object) {
      case ElasticIndex.nodes:
        return 'nodes';
      case ElasticIndex.documentVersions:
        return 'document_versions';
    }
  }
}
