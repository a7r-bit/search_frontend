import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:search_frontend/core/domain/entities/document_version.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/document_details/presentaition/cubit/link_cubit.dart';
import 'package:search_frontend/features/document_details/presentaition/widgets/document_version_action_menu.dart';

import '../../../../core/constants/index.dart';
import 'index.dart';

class DocumentVersionContainer extends StatefulWidget {
  final DocumentVersion documentVersion;
  const DocumentVersionContainer({super.key, required this.documentVersion});

  @override
  State<DocumentVersionContainer> createState() =>
      _DocumentVersionContainerState();
}

class _DocumentVersionContainerState extends State<DocumentVersionContainer> {
  bool isFocused = false;
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.card,
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(AppRadius.medium),
      borderOnForeground: true,
      child: InkWell(
        onFocusChange: (isFocused) =>
            setState(() => this.isFocused = isFocused),

        onHover: (value) => setState(() => isHovered = value),
        onTap: () async {
          context.read<LinkCubit>().openDocumentLink(widget.documentVersion);
        },
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isFocused == true || isHovered == true
                      ? Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.5)
                      : Theme.of(
                          context,
                        ).colorScheme.outline.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(AppRadius.medium),
                color: Theme.of(context).colorScheme.surfaceContainer,
              ),
              padding: EdgeInsets.all(AppPadding.small),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: widget
                            .documentVersion
                            .conversionStatus
                            .color
                            .withValues(alpha: 0.2),
                        child: Icon(
                          widget.documentVersion.conversionStatus.icon,
                          color: widget.documentVersion.conversionStatus.color,
                        ),
                      ),
                      SizedBox(width: SizeConfig.blockSizeHorizontal),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Версия: ${widget.documentVersion.version.toString()}",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Text(
                    widget.documentVersion.mediaFile != null
                        ? widget.documentVersion.mediaFile!.fileName
                        : "Файл не загружен",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  RowInfoWidget(
                    labelText: "Статус: ",
                    mainText: widget.documentVersion.conversionStatus.label,
                    mainTextStyle: Theme.of(context).textTheme.labelSmall,
                  ),
                  RowInfoWidget(
                    labelText: "Создано: ",
                    mainText: DateFormat.yMd().format(
                      widget.documentVersion.createdAt,
                    ),
                    mainTextStyle: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),

            Positioned(
              right: 5,
              top: 5,
              child: DocumentVersionActionMenu(
                documentVersion: widget.documentVersion,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
