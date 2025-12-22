import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:search_frontend/core/utils/index.dart';

import '../../../../core/constants/index.dart';
import '../../../../core/domain/entities/index.dart';

class VersionFilterMenu extends StatefulWidget {
  final Function({
    String? fileName,
    ConversionStatus? conversionStatus,
    String? sortParam,
    String? sortOrder,
  })
  onApply;

  final String? initialFileName;
  final ConversionStatus? initialConversionStatus;
  final String? initialSortParam;
  final String? initialSortOrder;

  const VersionFilterMenu({
    super.key,
    required this.onApply,
    this.initialFileName,
    this.initialConversionStatus,
    this.initialSortParam,
    this.initialSortOrder,
  });

  @override
  State<VersionFilterMenu> createState() => _FilterSortMenuState();
}

class _FilterSortMenuState extends State<VersionFilterMenu> {
  late TextEditingController fileNameController;
  late TextEditingController sortParamController;
  String? sortParamKey;
  ConversionStatus? conversionStatus;
  String? sortOrder;

  @override
  void initState() {
    super.initState();
    fileNameController = TextEditingController(text: widget.initialFileName);
    sortParamKey = widget.initialSortParam;
    sortParamController = TextEditingController(
      text: sortFields
          .firstWhere(
            (obj) => obj.keys.first == sortParamKey,
            orElse: () => {'': ""},
          )
          .values
          .first,
    );
    conversionStatus = widget.initialConversionStatus;
    sortOrder = widget.initialSortOrder;
  }

  final List<Map<String, dynamic>> sortFields = [
    {'version': "Версия"},
    {'fileName': "Название файла"},
    {'createdAt': "Дата создания"},
    {'updatedAt': "Дата обновления"},
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: fileNameController,

              decoration: const InputDecoration(
                labelText: 'Название файла',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical),

            Text("Статус", style: Theme.of(context).textTheme.labelMedium),
            SizedBox(height: SizeConfig.blockSizeVertical / 2),
            Wrap(
              spacing: AppPadding.extraSmall,
              runSpacing: AppPadding.extraSmall,
              children: ConversionStatus.values.map((status) {
                return ChoiceChip(
                  labelStyle: Theme.of(context).textTheme.labelLarge,
                  color: WidgetStatePropertyAll(
                    Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  visualDensity: VisualDensity.compact,
                  label: Text(status.label),
                  selected: conversionStatus == status,
                  onSelected: (selected) {
                    setState(() => conversionStatus = selected ? status : null);
                  },
                );
              }).toList(),
            ),
            SizedBox(height: SizeConfig.blockSizeVertical),

            Text('Сортировка', style: Theme.of(context).textTheme.labelMedium),
            SizedBox(height: SizeConfig.blockSizeVertical / 2),

            DropdownMenu<Map<String, dynamic>>(
              controller: sortParamController,
              inputDecorationTheme: Theme.of(context).inputDecorationTheme,
              enableFilter: true,
              width: SizeConfig.screenWidth,

              menuStyle: MenuStyle(
                maximumSize: WidgetStatePropertyAll(Size.fromWidth(250)),
              ),

              hintText: 'Выберите поле',

              dropdownMenuEntries: sortFields.map((obj) {
                return DropdownMenuEntry<Map<String, dynamic>>(
                  value: obj,
                  label: obj.values.first,
                );
              }).toList(),
              onSelected: (obj) => setState(() {
                sortParamController.text = obj!.values.first;
                sortParamKey = obj.keys.first;
              }),
            ),

            SizedBox(height: SizeConfig.blockSizeVertical),
            RadioListTile<String>(
              title: Text(
                'По возрастанию',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              value: 'asc',
              groupValue: sortOrder,
              onChanged: (value) => setState(() => sortOrder = value!),
            ),
            RadioListTile<String>(
              title: Text(
                'По убыванию',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              value: 'desc',
              groupValue: sortOrder,
              onChanged: (value) => setState(() => sortOrder = value!),
            ),
          ],
        ),
      ],
    );
    if (isMobile) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: AppPadding.medium,
            vertical: AppPadding.medium,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                content,
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          fileNameController.clear();
                          sortParamController.clear();
                          sortParamKey = null;
                          conversionStatus = null;
                          sortOrder = null;
                        });
                      },
                      icon: Icon(Icons.restart_alt_rounded),
                      style: Theme.of(context).iconButtonTheme.style,
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Отмена"),
                    ),
                    TextButton(
                      onPressed: () {
                        widget.onApply(
                          fileName: fileNameController.text.trim(),
                          conversionStatus: conversionStatus,
                          sortParam: sortParamKey,
                          sortOrder: sortOrder,
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("Применить"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return AlertDialog.adaptive(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Фильтрация"),
            IconButton(
              onPressed: () {
                setState(() {
                  fileNameController.clear();
                  sortParamController.clear();
                  sortParamKey = null;
                  conversionStatus = null;
                  sortOrder = null;
                });
              },
              icon: Icon(Icons.restart_alt_rounded),
              style: Theme.of(context).iconButtonTheme.style,
            ),
          ],
        ),
        content: content,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              widget.onApply(
                fileName: fileNameController.text.trim(),
                conversionStatus: conversionStatus,
                sortParam: sortParamKey,
                sortOrder: sortOrder,
              );
              log(sortParamController.text);
              Navigator.pop(context);
            },
            child: const Text('Применить'),
          ),
        ],
      );
    }
  }
}
