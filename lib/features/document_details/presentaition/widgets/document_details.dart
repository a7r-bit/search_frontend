import 'package:flutter/material.dart';
import '../../../../core/constants/index.dart';
import '../../../../core/domain/entities/index.dart';
import '../../../../core/utils/index.dart';
import 'index.dart';

class DocumentDetailWidget extends StatelessWidget {
  final Node node;
  final List<DocumentVersion> versions;
  const DocumentDetailWidget({
    super.key,
    required this.node,
    required this.versions,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          node.name,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
        if (node.description != null) ...[
          SizedBox(height: SizeConfig.blockSizeVertical),
          RichText(
            text: TextSpan(
              text: "Описание: ",
              style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              children: [
                TextSpan(
                  text: node.description!,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
        SizedBox(height: SizeConfig.blockSizeVertical),
        RowInfoWidget(
          labelText: "Дата создания: ",
          mainText: dateFormatter.format(node.createdAt.toLocal()),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical),
        RowInfoWidget(
          labelText: "Дата обновления: ",
          mainText: dateFormatter.format(node.updatedAt.toLocal()),
        ),
        SizedBox(height: SizeConfig.blockSizeVertical),
        RowInfoWidget(
          labelText: "Всего версий: ",
          mainText: versions.length.toString(),
        ),
      ],
    );
  }
}
