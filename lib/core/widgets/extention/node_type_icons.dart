import 'package:flutter/material.dart';
import 'package:search_frontend/core/domain/entities/index.dart';

extension NodeTypeIcon on NodeType {
  IconData get icon {
    switch (this) {
      case NodeType.DIRECTORY:
        return Icons.folder;
      case NodeType.DOCUMENT:
        return Icons.file_present_rounded;
    }
  }
}
