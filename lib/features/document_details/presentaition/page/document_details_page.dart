import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_details_bloc.dart';
import '../widgets/index.dart';

class DocumentDetailsPage extends StatelessWidget {
  final String documentId;
  const DocumentDetailsPage({super.key, required this.documentId});

  int _getActiveSortParamCount(DocumentDetailsState state) {
    if (state is DocumentDetailsLoaded) {
      final count = [
        state.conversionStatus,
        state.fileName,
        state.sortParam,
        state.sortOrder,
      ];
      return count.where((el) => el != null && el != "").length;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DocumentDetailsBloc, DocumentDetailsState>(
      builder: (context, state) {
        if (state is DocumentDetailsLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is DocumentDetailsLoaded) {
          final count = _getActiveSortParamCount(state);

          final displayText = !count.isNegative ? count.toString() : "";

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DocumentDetailWidget(
                document: state.document,
                versions: state.documentVersions,
              ),
              DicumentDetailsActionRow(
                documentId: documentId,
                count: count,
                displayText: displayText,
                state: state,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical),
              if (state.documentVersions.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      "Директория пуста",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              if (state.documentVersions.isNotEmpty)
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: AppPadding.small,
                      mainAxisSpacing: AppPadding.small,
                      childAspectRatio: Responsive.of<double>(
                        context: context,
                        mobile: 3 / 2.2,
                        tablet: 3 / 2,
                        desktop: 3 / /*2.6*/ 2,
                      ),
                      crossAxisCount: Responsive.of<int>(
                        context: context,
                        mobile: 2,
                        tablet: 3,
                        desktop: 4,
                      ),
                    ),

                    itemCount: state.documentVersions.length,
                    itemBuilder: (context, index) {
                      final documentVersion = state.documentVersions[index];
                      return DocumentVersionContainer(
                        documentVersion: documentVersion,
                      );
                    },
                  ),
                ),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
