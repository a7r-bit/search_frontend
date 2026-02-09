import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/features/document_details/presentaition/cubit/link_cubit.dart';
import 'package:search_frontend/features/documents/presentation/cubit/search_cubit.dart';

import 'dart:async';

import '../index.dart';

class SearchWidget extends StatefulWidget {
  final String? currentNodeId;
  const SearchWidget({super.key, required this.currentNodeId});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final SearchController _controller = SearchController();
  late final SearchCubit _searchCubit;
  late final LinkCubit _linkCubit;

  String? _currentQuery;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchCubit = context.read<SearchCubit>();
    _linkCubit = context.read<LinkCubit>();
  }

  Future<void> _search(String query) async {
    if (query.isEmpty) return;

    if (_currentQuery == query.trim()) {
      debugPrint('Skip duplicate query: $query');
      return;
    }

    _currentQuery = query.trim();

    await _searchCubit.search(
      currentNodeId: widget.currentNodeId,
      searchQuery: query,
    );

    if (_currentQuery != query) return;
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      isFullScreen: false,
      searchController: _controller,
      barHintText: "Поиск",

      onChanged: (value) {
        if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

        _debounceTimer = Timer(const Duration(milliseconds: 300), () {
          _search(value.trim());
        });
      },

      suggestionsBuilder: (context, controller) {
        debugPrint('suggestionsBuilder called, text: ${controller.text}');
        debugPrint('searchCubit state: ${_searchCubit.state}');

        final state = _searchCubit.state;
        // final state = context.watch<SearchCubit>().state;

        Iterable<Widget> suggestions = [];

        if (state is SearchLoading) {
          // return _lastSuggestions;
          suggestions = [const Center(child: CircularProgressIndicator())];
        }
        if (state is SearchLoaded) {
          if (state.searchResults.isEmpty) {
            suggestions = [const Center(child: Text("Запись не найдена"))];
          } else {
            suggestions = state.searchResults.map((searchItem) {
              return SearchBarListTile(
                searchItem: searchItem,
                controller: controller,
                linkCubit: _linkCubit,
              );
            }).toList();
          }
        }

        return suggestions;
      },
    );
  }
}
