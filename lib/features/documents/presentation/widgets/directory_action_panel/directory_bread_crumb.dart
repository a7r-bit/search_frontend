import 'package:flutter/material.dart';
import 'package:flutter_breadcrumb/flutter_breadcrumb.dart';
import 'package:go_router/go_router.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/domain/entities/path_part.dart';

class DirectoryBreadcrumb extends StatelessWidget {
  final List<PathPart> path;

  const DirectoryBreadcrumb({required this.path, super.key});

  @override
  Widget build(BuildContext context) {
    return BreadCrumb(
      overflow: ScrollableOverflow(),
      items: path.map((part) {
        return BreadCrumbItem(
          textColor: Theme.of(context).colorScheme.onSurface,

          borderRadius: BorderRadiusGeometry.circular(AppRadius.small),
          content: Text(
            part.name,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: path.last == part
                  ? Theme.of(context).colorScheme.onSurfaceVariant
                  : Theme.of(context).colorScheme.onSurface,
              fontWeight: path.last == part ? FontWeight.w600 : FontWeight.w300,
            ),
          ),
          onTap: () => context.goNamed(
            "node",
            pathParameters: {"nodeId": part.id ?? "root"},
          ),
        );
      }).toList(),
      divider: Icon(Icons.chevron_right, size: 16, color: Colors.grey),
    );
  }
}
