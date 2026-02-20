import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/features/document_details/presentaition/cubit/link_cubit.dart';
import 'package:search_frontend/features/documents/presentation/cubit/search_cubit.dart';

import 'dart:async';
import '../index.dart';

typedef Debounceable<S, T> = Future<S> Function(T value);

Debounceable<S, T> debounce<S, T>(
  Debounceable<S, T> function,
  Duration duration,
) {
  Timer? timer;
  int callId = 0;

  return (T value) async {
    callId++;
    final int currentCall = callId;

    timer?.cancel();

    final completer = Completer<S>();

    timer = Timer(duration, () async {
      try {
        final result = await function(value);

        if (currentCall != callId) return;

        if (!completer.isCompleted) {
          completer.complete(result);
        }
      } catch (e, st) {
        if (!completer.isCompleted) {
          completer.completeError(e, st);
        }
      }
    });

    return completer.future;
  };
}

class SearchWidget extends StatefulWidget {
  final String? currentNodeId;
  const SearchWidget({super.key, required this.currentNodeId});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final SearchController _controller = SearchController();

  late final LinkCubit _linkCubit;

  Iterable<Widget> _lastSuggestions = const [];
  late final Debounceable<Iterable<Widget>, String> _debouncedSearch;

  @override
  void initState() {
    super.initState();
    _linkCubit = context.read<LinkCubit>();

    _debouncedSearch = debounce(_search, const Duration(milliseconds: 300));
  }

  Future<Iterable<Widget>> _search(String query) async {
    if (query.isEmpty) return _lastSuggestions;
    if (!mounted) return _lastSuggestions;

    await context.read<SearchCubit>().search(
      currentNodeId: widget.currentNodeId,
      searchQuery: query,
    );

    final state = context.read<SearchCubit>().state;

    if (state is! SearchLoaded) {
      return _lastSuggestions;
    }

    _lastSuggestions = state.searchResults.map(
      (item) => SearchBarListTile(
        searchItem: item,
        controller: _controller,
        linkCubit: _linkCubit,
      ),
    );

    return _lastSuggestions;
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      searchController: _controller,
      isFullScreen: false,
      barHintText: 'Поиск',

      suggestionsBuilder: (context, controller) async {
        return _debouncedSearch(controller.text);
      },
    );
  }
}
