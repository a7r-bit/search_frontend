import 'package:json_annotation/json_annotation.dart';
import 'package:search_frontend/core/domain/entities/index.dart';

class ConversionStatusConverter
    extends JsonConverter<ConversionStatus, String> {
  const ConversionStatusConverter();
  @override
  ConversionStatus fromJson(String json) {
    switch (json) {
      case 'PENDING':
        return ConversionStatus.PENDING;
      case 'IN_PROGRESS':
        return ConversionStatus.IN_PROGRESS;
      case 'DONE':
        return ConversionStatus.DONE;
      case 'FAILED':
        return ConversionStatus.FAILED;
      default:
        return ConversionStatus.FAILED;
    }
  }

  @override
  String toJson(ConversionStatus status) => status.name;
}
