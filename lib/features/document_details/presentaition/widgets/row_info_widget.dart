import 'package:flutter/material.dart';

class RowInfoWidget extends StatelessWidget {
  final String labelText;
  final TextStyle? labelstyle;
  final String mainText;
  final TextStyle? mainTextStyle;

  const RowInfoWidget({
    super.key,
    required this.mainText,
    required this.labelText,
    this.labelstyle,
    this.mainTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          labelText,
          style:
              labelstyle ??
              Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
        Text(
          mainText,
          style:
              mainTextStyle ??
              Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
      ],
    );
  }
}
