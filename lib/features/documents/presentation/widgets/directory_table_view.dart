import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/domain/entities/index.dart';

class DirectoryTableView extends StatefulWidget {
  final PathPart currenPath;

  final List<FileNode> children;

  const DirectoryTableView({
    super.key,
    required this.children,
    required this.currenPath,
  });

  @override
  State<DirectoryTableView> createState() => _DirectoryTableViewState();
}

class _DirectoryTableViewState extends State<DirectoryTableView> {
  List<PlutoRow> _buildRows() {
    return widget.children.map((node) {
      return PlutoRow(
        cells: {
          'id': PlutoCell(value: node.id),
          'name': PlutoCell(value: node.name),
          'type': PlutoCell(value: node.type),
          'description': PlutoCell(value: node.description ?? ""),
          'parentId': PlutoCell(value: node.parentId ?? ""),
          'created': PlutoCell(value: node.createdAt),
          'updated': PlutoCell(value: node.updatedAt),
          'actions': PlutoCell(value: ''),
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final gridColumns = [
      PlutoColumn(title: "Id", field: "id", type: PlutoColumnType.text()),
      PlutoColumn(
        title: 'Название',
        field: 'name',
        minWidth: 200,

        enableAutoEditing: false,
        enableEditingMode: false,
        type: PlutoColumnType.text(),
        renderer: (ctx) {
          final name = ctx.row.cells['name']!.value;
          final type = ctx.row.cells['type']!.value;
          final id = ctx.row.cells['id']!.value;
          return GestureDetector(
            onTap: () {
              if (type == "directory") {
                context.goNamed(
                  "directory",
                  pathParameters: {"directoryId": id},
                );
              } else if (type == 'document') {
                context.goNamed(
                  'documentDetails',
                  pathParameters: {
                    'directoryId': widget.currenPath.id ?? "root",
                    'id': id,
                  },
                );
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
          final type = rendererContext.cell.value as String;

          return Icon(
            type == 'directory' ? Icons.folder : Icons.file_present_rounded,
            size: 30,
            color: Theme.of(context).colorScheme.primary,
          );
        },
      ),
      PlutoColumn(
        title: "Описание",
        field: "description",
        type: PlutoColumnType.text(),
      ),
      PlutoColumn(
        title: "Родительский id",
        field: "parentId",
        type: PlutoColumnType.text(),
        // hide: true,
      ),

      PlutoColumn(
        title: 'Дата создания',
        field: 'created',
        type: PlutoColumnType.date(),
      ),
      PlutoColumn(
        title: 'Дата обновления',
        field: 'updated',
        type: PlutoColumnType.date(),
      ),
      PlutoColumn(
        title: '',
        field: 'actions',
        type: PlutoColumnType.text(),
        enableSorting: false,
        enableDropToResize: false,
        enableColumnDrag: false,
        textAlign: PlutoColumnTextAlign.center,
        titleTextAlign: PlutoColumnTextAlign.center,
        enableContextMenu: false,

        width: 60,
        minWidth: 40,
        renderer: (ctx) => IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {},
          visualDensity: VisualDensity.compact,
        ),
      ),
    ];
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
          gridBorderRadius: BorderRadiusGeometry.circular(AppRadius.medium),
          columnTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
          cellTextStyle: Theme.of(context).textTheme.bodyMedium!,

          gridBackgroundColor: Theme.of(context).colorScheme.surfaceContainer,

          rowColor: Theme.of(context).colorScheme.surfaceContainer,
          iconColor: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
          activatedColor: Theme.of(context).colorScheme.surfaceContainerLow,
          activatedBorderColor: Theme.of(context).colorScheme.outline,
        ),

        scrollbar: PlutoGridScrollbarConfig(draggableScrollbar: true),
        columnSize: PlutoGridColumnSizeConfig(),

        localeText: PlutoGridLocaleText.russian(),
      ),
      columns: gridColumns,
      rows: _buildRows(),
    );
  }
}
