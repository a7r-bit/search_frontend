import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/features/documents/presentation/cubit/search_cubit.dart';

import 'dart:async';

import 'index.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final SearchController _controller = SearchController();
  late final SearchCubit _cubit;

  String? _currentQuery;
  Iterable<Widget> _lastSuggestions = <Widget>[];

  @override
  void initState() {
    super.initState();
    _cubit = context.read<SearchCubit>();
  }

  Future<void> _search(String query) async {
    _currentQuery = query;
    if (query.isEmpty) {
      _cubit.reset();
      return;
    }
    await _cubit.search(query);

    if (_currentQuery != query) return;
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      isFullScreen: false,
      searchController: _controller,
      barHintText: "Поиск директории",

      onChanged: (value) {
        _search(value.trim());
      },

      suggestionsBuilder: (context, controller) async {
        final state = _cubit.state;

        Iterable<Widget> suggestions = [];

        if (state is SearchLoading) {
          return _lastSuggestions;
        }
        if (state is SearchLoaded) {
          if (state.files.isEmpty) {
            suggestions = [const Center(child: Text("Запись не найдена"))];
          } else {
            suggestions = state.files.map((node) {
              return SearchBarListTile(node: node, controller: controller);
            }).toList();
          }
        }

        return _lastSuggestions = suggestions;
      },
    );
  }
}
