import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/index.dart';
import '../../../../../core/utils/index.dart';
import '../../bloc/node_bloc.dart';
import '../../bloc/node_explorer_bloc.dart';
import '../directory_action_panel/index.dart';
import '../directory_main_container/directory_card_view.dart';

class NodeMoveDialog extends StatelessWidget {
  const NodeMoveDialog({super.key, required this.nodeId});

  final String nodeId;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 800,
          maxHeight: SizeConfig.screenHeight * 0.8,
        ),
        // width: dialogWidth,
        // height: dialogWidth,
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.medium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DirectoryBreadcrumb(mode: DirectoryViewMode.move),

              SizedBox(height: 12),

              Expanded(
                child: DirectoryCardView(
                  showActions: false,
                  mode: DirectoryViewMode.move,
                ),
              ),

              SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Отменить'),
                  ),
                  const SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      final explorerState = context
                          .read<NodeExplorerBloc>()
                          .state;

                      if (explorerState is NodeLoadLoaded) {
                        final newParentId = explorerState.path.last.id;

                        context.read<NodeBloc>().add(
                          MoveNode(nodeId: nodeId, newParentId: newParentId),
                        );

                        Navigator.pop(context, true);
                      }
                    },
                    child: const Text('Переместить сюда'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
