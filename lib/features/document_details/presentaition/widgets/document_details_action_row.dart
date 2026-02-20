import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/domain/entities/document_version.dart';
import 'package:search_frontend/core/utils/injection.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_details_bloc.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_upload_bloc.dart';

import '../../../../core/constants/index.dart';
import '../../../../core/utils/index.dart';
import 'index.dart';

class DicumentDetailsActionRow extends StatelessWidget {
  const DicumentDetailsActionRow({
    super.key,
    required this.documentId,
    required this.count,
    required this.displayText,
    required this.state,
  });

  final DocumentDetailsLoaded state;
  final String documentId;
  final int count;
  final String displayText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            final parentContext = context;
            _showFilterMenu(parentContext);
          },

          icon: Badge(
            isLabelVisible: count != 0,
            label: Text(
              displayText,
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.error,
            child: Icon(Icons.filter_alt_rounded),
          ),
        ),

        SizedBox(width: SizeConfig.blockSizeHorizontal),

        TextButton.icon(
          style: ButtonStyle(
            visualDensity: VisualDensity.comfortable,
            shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(AppRadius.small),
              ),
            ),
            backgroundColor: WidgetStatePropertyAll(
              Theme.of(context).colorScheme.secondaryContainer,
            ),
          ),
          onPressed: () =>
              showDialog(
                context: context,
                builder: (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(value: getIt<DocumentUploadBloc>()),

                    BlocProvider.value(value: getIt<ErrorBloc>()),
                  ],
                  child: FilePickerDialog(documetnId: documentId),
                ),
              ).then(
                (value) => value is DocumentVersion
                    ? {
                        context.read<DocumentDetailsBloc>().add(
                          LoadDocumentDetails(nodeId: documentId),
                        ),
                      }
                    : {},
              ),
          label: Text("Добавить"),
          icon: Icon(Icons.add),
        ),
      ],
    );
  }

  void _showFilterMenu(BuildContext parentContext) {
    final isMobile = Responsive.isMobile(parentContext);

    final menu = VersionFilterMenu(
      initialFileName: state.fileName,
      initialConversionStatus: state.conversionStatus,
      initialSortParam: state.sortParam,
      initialSortOrder: state.sortOrder,
      onApply: ({conversionStatus, fileName, sortOrder, sortParam}) {
        parentContext.read<DocumentDetailsBloc>().add(
          LoadDocumentDetails(
            nodeId: documentId,
            conversionStatus: conversionStatus,
            fileName: fileName,
            sortOrder: sortOrder,
            sortParam: sortParam,
          ),
        );
      },
    );

    if (!isMobile) {
      showDialog(
        context: parentContext,
        builder: (_) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: menu,
          ),
        ),
      );
    } else {
      showModalBottomSheet(
        useRootNavigator: true,
        context: parentContext,
        builder: (_) => SafeArea(
          child: Padding(padding: const EdgeInsets.all(4), child: menu),
        ),
      );
    }
  }
}
