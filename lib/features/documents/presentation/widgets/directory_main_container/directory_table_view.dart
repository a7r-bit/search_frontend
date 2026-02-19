import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/domain/entities/index.dart';

import '../../bloc/node_explorer_bloc.dart';

// class DirectoryTableView extends StatefulWidget {
//   final PathPart currenPath;

//   final List<Node> children;

//   const DirectoryTableView({
//     super.key,
//     required this.children,
//     required this.currenPath,
//   });

//   @override
//   State<DirectoryTableView> createState() => _DirectoryTableViewState();
// }

// class _DirectoryTableViewState extends State<DirectoryTableView> {
//   List<PlutoRow> _buildRows() {
//     return widget.children.map((node) {
//       return PlutoRow(
//         cells: {
//           'id': PlutoCell(value: node.id),
//           'name': PlutoCell(value: node.name),
//           'type': PlutoCell(value: node.type.name),
//           'description': PlutoCell(value: node.description ?? ""),
//           'parentId': PlutoCell(value: node.parentId ?? ""),
//           'created': PlutoCell(value: node.createdAt),
//           'updated': PlutoCell(value: node.updatedAt),
//           // 'actions': PlutoCell(value: ''),
//         },
//       );
//     }).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final gridColumns = [
//       PlutoColumn(
//         title: "Id",
//         field: "id",
//         type: PlutoColumnType.text(),
//         enableEditingMode: false,
//       ),
//       PlutoColumn(
//         title: 'Название',
//         field: 'name',
//         minWidth: 200,

//         enableAutoEditing: false,
//         enableEditingMode: false,
//         type: PlutoColumnType.text(),
//         renderer: (ctx) {
//           final name = ctx.row.cells['name']!.value;
//           final typeStr = ctx.row.cells['type']!.value;
//           final id = ctx.row.cells['id']!.value;
//           return GestureDetector(
//             onTap: () {
//               final type = NodeType.values.firstWhere(
//                 (e) => e.name == typeStr,
//                 orElse: () => NodeType.DIRECTORY, // добавьте UNKNOWN в enum
//               );

//               switch (type) {
//                 case NodeType.DIRECTORY:
//                   context.goNamed("node", pathParameters: {"nodeId": id});
//                   break;
//                 case NodeType.DOCUMENT:
//                   context.goNamed(
//                     'documentDetails',
//                     pathParameters: {
//                       'nodeId': widget.currenPath.id ?? "root",
//                       'id': id,
//                     },
//                   );
//                   break;
//               }
//             },
//             child: Text(name),
//           );
//         },
//       ),
//       PlutoColumn(
//         title: 'Тип',
//         field: 'type',
//         type: PlutoColumnType.text(),
//         enableEditingMode: false,
//         renderer: (rendererContext) {
//           final typeStr = rendererContext.cell.value as String;

//           final nodeType = NodeType.values.firstWhere(
//             (e) => e.name == typeStr,
//             orElse: () => NodeType.DIRECTORY,
//           );

//           return Icon(
//             nodeType.icon,
//             size: 30,
//             color: Theme.of(context).colorScheme.primary,
//           );
//         },
//       ),
//       PlutoColumn(
//         title: "Описание",
//         field: "description",
//         type: PlutoColumnType.text(),
//         enableEditingMode: false,
//       ),
//       PlutoColumn(
//         title: "Родительский id",
//         field: "parentId",
//         type: PlutoColumnType.text(),
//         enableEditingMode: false,
//         // hide: true,
//       ),

//       PlutoColumn(
//         enableEditingMode: false,
//         title: 'Дата создания',
//         field: 'created',
//         type: PlutoColumnType.date(),
//       ),
//       PlutoColumn(
//         enableEditingMode: false,
//         title: 'Дата обновления',
//         field: 'updated',
//         type: PlutoColumnType.date(),
//       ),
//     ];
//     return PlutoGrid(
//       configuration: PlutoGridConfiguration(
//         columnFilter: PlutoGridColumnFilterConfig(
//           filters: [...FilterHelper.defaultFilters],
//           resolveDefaultColumnFilter: (column, resolver) {
//             if (column.field == 'name') {
//               return resolver<PlutoFilterTypeContains>()!;
//             }
//             return resolver<PlutoFilterTypeContains>()!;
//           },
//         ),

//         style: PlutoGridStyleConfig(
//           gridBorderRadius: BorderRadiusGeometry.circular(AppRadius.medium),
//           columnTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
//             color: Theme.of(context).colorScheme.onSurface,
//             fontWeight: FontWeight.w500,
//           ),
//           cellTextStyle: Theme.of(context).textTheme.bodySmall!,

//           gridBackgroundColor: Theme.of(context).colorScheme.surfaceContainer,

//           rowColor: Theme.of(context).colorScheme.surfaceContainer,
//           iconColor: Theme.of(context).brightness == Brightness.dark
//               ? Colors.white
//               : Colors.black,
//           activatedColor: Theme.of(context).colorScheme.surfaceContainerLow,
//           activatedBorderColor: Theme.of(context).colorScheme.outline,
//         ),

//         scrollbar: PlutoGridScrollbarConfig(draggableScrollbar: true),
//         columnSize: PlutoGridColumnSizeConfig(),

//         localeText: PlutoGridLocaleText.russian(),
//       ),
//       columns: gridColumns,
//       rows: _buildRows(),
//     );
//   }
// }
class DirectoryTableView extends StatelessWidget {
  // final PathPart currenPath;

  // final List<Node> children;

  const DirectoryTableView({
    super.key,
    // required this.children,
    // required this.currenPath,
  });

  List<PlutoRow> _buildRows(List<Node> children) {
    return children.map((node) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: node.id),
          'name': PlutoCell(value: node.name),
          'type': PlutoCell(value: node.type.name),
          'description': PlutoCell(value: node.description ?? ""),
          'parentId': PlutoCell(value: node.parentId ?? ""),
          'created': PlutoCell(value: node.createdAt),
          'updated': PlutoCell(value: node.updatedAt),
          // 'actions': PlutoCell(value: ''),
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> _buildColumns(PathPart currenPath) {
      return [
        PlutoColumn(
          title: "Id",
          field: "id",
          type: PlutoColumnType.text(),
          enableEditingMode: false,
        ),
        PlutoColumn(
          title: 'Название',
          field: 'name',
          minWidth: 200,

          enableAutoEditing: false,
          enableEditingMode: false,
          type: PlutoColumnType.text(),
          renderer: (ctx) {
            final name = ctx.row.cells['name']!.value;
            final typeStr = ctx.row.cells['type']!.value;
            final id = ctx.row.cells['id']!.value;
            return GestureDetector(
              onTap: () {
                final type = NodeType.values.firstWhere(
                  (e) => e.name == typeStr,
                  orElse: () => NodeType.DIRECTORY, // добавьте UNKNOWN в enum
                );

                switch (type) {
                  case NodeType.DIRECTORY:
                    context.goNamed("node", pathParameters: {"nodeId": id});
                    break;
                  case NodeType.DOCUMENT:
                    context.goNamed(
                      'documentDetails',
                      pathParameters: {
                        'nodeId': currenPath.id ?? "root",
                        'id': id,
                      },
                    );
                    break;
                }
              },
              child: Text(name),
            );
          },
        ),
        PlutoColumn(
          title: 'Тип',
          field: 'type',
          type: PlutoColumnType.text(),
          enableEditingMode: false,
          renderer: (rendererContext) {
            final typeStr = rendererContext.cell.value as String;

            final nodeType = NodeType.values.firstWhere(
              (e) => e.name == typeStr,
              orElse: () => NodeType.DIRECTORY,
            );

            return Icon(
              nodeType.icon,
              size: 30,
              color: Theme.of(context).colorScheme.primary,
            );
          },
        ),
        PlutoColumn(
          title: "Описание",
          field: "description",
          type: PlutoColumnType.text(),
          enableEditingMode: false,
        ),
        PlutoColumn(
          title: "Родительский id",
          field: "parentId",
          type: PlutoColumnType.text(),
          enableEditingMode: false,
          // hide: true,
        ),

        PlutoColumn(
          enableEditingMode: false,
          title: 'Дата создания',
          field: 'created',
          type: PlutoColumnType.date(),
        ),
        PlutoColumn(
          enableEditingMode: false,
          title: 'Дата обновления',
          field: 'updated',
          type: PlutoColumnType.date(),
        ),
      ];
    }

    return BlocBuilder<NodeExplorerBloc, NodeExplorerState>(
      builder: (context, state) {
        if (state is NodeLoadLoading) {
          return Center(child: CircularProgressIndicator.adaptive());
        }
        if (state is NodeLoadLoaded) {
          final children = state.children;
          final currenPath = state.path.last;
          if (children.isEmpty) {
            return Center(
              child: Text(
                "Нет элементов",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }

          return PlutoGrid(
            configuration: PlutoGridConfiguration(
              columnFilter: PlutoGridColumnFilterConfig(
                filters: [...FilterHelper.defaultFilters],
                resolveDefaultColumnFilter: (column, resolver) {
                  if (column.field == 'name') {
                    return resolver<PlutoFilterTypeContains>()!;
                  }
                  return resolver<PlutoFilterTypeContains>()!;
                },
              ),

              style: PlutoGridStyleConfig(
                gridBorderRadius: BorderRadiusGeometry.circular(
                  AppRadius.medium,
                ),
                columnTextStyle: Theme.of(context).textTheme.bodyMedium!
                    .copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                cellTextStyle: Theme.of(context).textTheme.bodySmall!,

                gridBackgroundColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainer,

                rowColor: Theme.of(context).colorScheme.surfaceContainer,
                iconColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                activatedColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerLow,
                activatedBorderColor: Theme.of(context).colorScheme.outline,
              ),

              scrollbar: PlutoGridScrollbarConfig(draggableScrollbar: true),
              columnSize: PlutoGridColumnSizeConfig(),

              localeText: PlutoGridLocaleText.russian(),
            ),
            columns: _buildColumns(currenPath),
            rows: _buildRows(children),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
