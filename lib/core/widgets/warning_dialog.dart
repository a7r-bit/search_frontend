import 'package:flutter/material.dart';

class WarningDialog<T> extends StatelessWidget {
  final String title;
  final String? description;
  final Future<T> Function() okFunction;

  const WarningDialog({
    super.key,
    required this.title,
    this.description,
    required this.okFunction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: Theme.of(context).colorScheme.surface,
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      title: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              softWrap: true,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            if (description != null) ...[
              const SizedBox(height: 8),
              Text(
                description!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                softWrap: true,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () async {
            await okFunction();
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('ОК'),
        ),
      ],
    );
  }
}
