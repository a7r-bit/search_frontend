import 'package:flutter/material.dart';
import 'package:search_frontend/core/domain/entities/document_version.dart';

extension ConversionStatusExtension on ConversionStatus {
  String get label {
    switch (this) {
      case ConversionStatus.PENDING:
        return 'Ожидает';
      case ConversionStatus.IN_PROGRESS:
        return 'В процессе';
      case ConversionStatus.DONE:
        return 'Конвертирован';
      case ConversionStatus.FAILED:
        return 'Ошибка';
    }
  }

  IconData get icon {
    switch (this) {
      case ConversionStatus.PENDING:
        return Icons.pending_outlined;
      case ConversionStatus.IN_PROGRESS:
        return Icons.autorenew;
      case ConversionStatus.DONE:
        return Icons.check_circle_outline;
      case ConversionStatus.FAILED:
        return Icons.error_outline;
    }
  }

  Color get color {
    switch (this) {
      case ConversionStatus.PENDING:
        return Colors.orange;
      case ConversionStatus.IN_PROGRESS:
        return Colors.blue;
      case ConversionStatus.DONE:
        return Colors.green;
      case ConversionStatus.FAILED:
        return Colors.red;
    }
  }
}
