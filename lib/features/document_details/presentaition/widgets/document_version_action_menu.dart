import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/domain/entities/document_version.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_details_bloc.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_version_delete_bloc.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_version_update_bloc.dart';

import '../../../../core/utils/injection.dart';
import '../../../../core/widgets/index.dart';
import 'index.dart';

class DocumentVersionActionMenu extends StatelessWidget {
  final DocumentVersion documentVersion;
  const DocumentVersionActionMenu({super.key, required this.documentVersion});

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return IconButton(
          icon: const Icon(Icons.more_vert, size: 18),
          padding: EdgeInsets.zero,
          onPressed: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
        );
      },
      menuChildren: [
        MenuItemButton(
          leadingIcon: Icon(Icons.update),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => BlocProvider(
                create: (context) =>
                    DocumentVersionUpdateBloc(repository: getIt()),
                child: DocumentVersionUpdateDialog(
                  documentVersion: documentVersion,
                ),
              ),
            ).then(
              (value) => value is DocumentVersion
                  ? {
                      context.read<DocumentDetailsBloc>().add(
                        ReloadDocumentDetails(),
                      ),
                    }
                  : {},
            );
          },
          child: Text(
            'Обновить',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        const PopupMenuDivider(height: 2),
        MenuItemButton(
          leadingIcon: Icon(Icons.delete_outline),
          onPressed: () async {
            showDialog(
              context: context,
              builder: (dialogContext) {
                return BlocProvider<DocumentVersionDeleteBloc>(
                  create: (_) => DocumentVersionDeleteBloc(
                    documentVersionRepository: getIt(),
                  ),
                  child:
                      BlocListener<
                        DocumentVersionDeleteBloc,
                        DocumentVersionDeleteState
                      >(
                        listener: (listenerContext, state) {
                          if (state is DocumentVersionDeleteSuccess) {
                            context.read<DocumentDetailsBloc>().add(
                              ReloadDocumentDetails(),
                            );
                          }
                        },
                        child: Builder(
                          builder: (innerContext) {
                            return WarningDialog(
                              title: "Подтвердите удаление",
                              description:
                                  "Вы уверены, что хотите удалить версию документа?",
                              okFunction: () async {
                                innerContext
                                    .read<DocumentVersionDeleteBloc>()
                                    .add(
                                      DeleteDocumentVersionEvent(
                                        doumentversionId: documentVersion.id,
                                      ),
                                    );
                              },
                            );
                          },
                        ),
                      ),
                );
              },
            );
          },

          child: Text('Удалить', style: Theme.of(context).textTheme.labelSmall),
        ),
      ],
    );
  }
}
