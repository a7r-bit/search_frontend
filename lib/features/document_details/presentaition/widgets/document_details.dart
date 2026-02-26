import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/utils/cubit/ui_state_cubit.dart';
import '../../../../core/constants/index.dart';
import '../../../../core/domain/entities/index.dart';
import '../../../../core/utils/index.dart';
import 'index.dart';

class DocumentDetailWidget extends StatefulWidget {
  final Node node;
  final List<DocumentVersion> versions;
  const DocumentDetailWidget({
    super.key,
    required this.node,
    required this.versions,
  });

  @override
  State<DocumentDetailWidget> createState() => _DocumentDetailWidgetState();
}

class _DocumentDetailWidgetState extends State<DocumentDetailWidget>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final expanded = context.select<UiStateCubit, bool>(
      (cubit) => cubit.state.showDocumentDetailsDetails,
    );

    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                widget.node.name,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            IconButton(
              onPressed: () => context
                  .read<UiStateCubit>()
                  .toggleShowDocumentDetailsDetails(),
              icon: AnimatedRotation(
                turns: expanded ? 0 : 0.5,
                duration: const Duration(milliseconds: 300),
                child: const Icon(Icons.expand_more),
              ),
            ),
          ],
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: expanded
                ? const BoxConstraints()
                : const BoxConstraints(maxHeight: 0),

            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeOut,
              child: expanded
                  ? _DetailContent(node: widget.node, versions: widget.versions)
                  : const SizedBox.shrink(),
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailContent extends StatelessWidget {
  final Node node;
  final List<DocumentVersion> versions;
  const _DetailContent({required this.node, required this.versions});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
