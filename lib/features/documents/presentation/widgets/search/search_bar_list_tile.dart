import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:search_frontend/core/constants/constants.dart';
import 'package:search_frontend/features/document_details/presentaition/cubit/link_cubit.dart';
import '../../../../../core/domain/entities/index.dart';
import '../../../data/models/search_result.dart';

class SearchBarListTile extends StatelessWidget {
  final SearchController controller;
  final BaseSearchResultDTO searchItem;
  final LinkCubit linkCubit;

  const SearchBarListTile({
    super.key,
    required this.searchItem,
    required this.controller,
    required this.linkCubit,
  });

  @override
  Widget build(BuildContext context) {
    if (searchItem is NodeSearchResultDTO) {
      return _buildNodeSearchTile(context, searchItem as NodeSearchResultDTO);
    }

    if (searchItem is DocumentVersionSearchResultDTO) {
      return _buildDocumentVersionSearchTile(
        context,
        searchItem as DocumentVersionSearchResultDTO,
      );
    }
    return const SizedBox();
  }

  ListTile _buildDocumentVersionSearchTile(
    BuildContext context,
    DocumentVersionSearchResultDTO item,
  ) {
    return ListTile(
      leading: CircleAvatar(child: const Icon(Icons.description_outlined)),
      titleTextStyle: Theme.of(context).textTheme.labelMedium,

      title: Text(item.fileName, maxLines: 1),
      subtitle: highlightText(
        item.highlight?.buildHighlight() ?? "",
        style: Theme.of(context).textTheme.labelSmall,
      ),
      onTap: () async {
        linkCubit.openDocumentLink(item.fileUrl);

        controller.closeView(item.fileName);
      },
    );
  }

  ListTile _buildNodeSearchTile(
    BuildContext context,
    NodeSearchResultDTO item,
  ) {
    return ListTile(
      leading: CircleAvatar(child: Icon(item.type.icon)),
      title: Text(item.name, maxLines: 1),
      subtitle: highlightText(
        item.highlight?.buildHighlight() ?? "",
        style: Theme.of(context).textTheme.labelSmall,
      ),
      onTap: () {
        switch (item.type) {
          case NodeType.DIRECTORY:
            context.goNamed("node", pathParameters: {"nodeId": item.id});
          // TODO
          case NodeType.DOCUMENT:
            context.goNamed(
              "documentDetails",
              pathParameters: {"nodeId": item.id, "id": item.id},
            );
        }

        controller.closeView(item.name);
      },
    );
  }
}
