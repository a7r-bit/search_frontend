import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/constants/index.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/saved_directories_bloc.dart';
import 'package:search_frontend/features/documents/presentation/widgets/saved_node_card.dart';

class QuickAccessContainer extends StatelessWidget {
  const QuickAccessContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppPadding.small + 2),
      child: BlocBuilder<SavedDirectoriesBloc, SavedDirectoriesState>(
        builder: (context, state) {
          if (state is SavedDirectoriesLoading) {
            return SizedBox(
              height: 140,
              child: Center(child: CircularProgressIndicator.adaptive()),
            );
          } else if (state is SavedDirectoriesLoaded &&
              state.directories.isNotEmpty) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Сохраненные директории",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical),
                ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    },
                  ),
                  child: SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,

                      physics: const BouncingScrollPhysics(),
                      itemCount: state.directories.length,
                      itemBuilder: (context, index) {
                        final directory = state.directories[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.small,
                          ),
                          child: SavedDirectoryCard(node: directory),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
