import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/documents/presentation/bloc/directory_bloc.dart';
import 'package:search_frontend/features/documents/presentation/bloc/saved_directories_bloc.dart';
import 'package:search_frontend/features/documents/presentation/widgets/index.dart';
import 'package:search_frontend/features/documents/presentation/widgets/directory_container.dart';

import '../../../../core/utils/injection.dart';

class DocumentsPage extends StatelessWidget {
  final String? directoryId;
  const DocumentsPage({super.key, this.directoryId});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<SavedDirectoriesBloc>(
          create: (_) =>
              getIt<SavedDirectoriesBloc>()..add(LoadSavedDirectories()),
        ),
        BlocProvider<DirectoryBloc>(
          create: (_) =>
              getIt<DirectoryBloc>()..add(LoadChildren(parentId: directoryId)),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (!Responsive.isDesktop(context))
            SizedBox(width: double.infinity, child: SearchWidget()),
          if (!Responsive.isDesktop(context))
            SizedBox(height: SizeConfig.blockSizeVertical),
          QuickAccessContainer(),
          SizedBox(height: SizeConfig.blockSizeVertical),
          Expanded(child: DirectoryContainer()),
        ],
      ),
    );
  }
}
