import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:search_frontend/core/utils/bloc/error_bloc.dart';
import 'package:search_frontend/core/utils/cubit/ui_state_cubit.dart';
import 'package:search_frontend/core/utils/injection.dart';
import 'package:search_frontend/core/utils/responsive.dart';
import 'package:search_frontend/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:search_frontend/features/auth/presentation/page/auth_page.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_details_bloc.dart';
import 'package:search_frontend/features/document_details/presentaition/cubit/link_cubit.dart';
import 'package:search_frontend/features/document_details/presentaition/page/document_details_page.dart';
import 'package:search_frontend/features/documents/presentation/cubit/node_sort_cubit.dart';
import 'package:search_frontend/features/documents/presentation/cubit/search_cubit.dart';
import 'package:search_frontend/features/documents/presentation/page/documents_page.dart';
import 'package:search_frontend/features/main_layout/presentation/page/main_layout.dart';

import '../../features/documents/presentation/widgets/index.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter goRouter = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            BlocProvider(create: (_) => getIt<AuthCubit>(), child: AuthPage()),
      ),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          //
          final rawNodeId = state.pathParameters['nodeId'];
          final String? currentNodeId = rawNodeId == 'root' ? null : rawNodeId;

          final isNodeRoute = state.matchedLocation.startsWith("/node/");
          final showHeader = isNodeRoute && state.pathParameters.length == 1;

          return MultiBlocProvider(
            providers: [
              BlocProvider<UiStateCubit>.value(value: getIt<UiStateCubit>()),

              BlocProvider<SearchCubit>(create: (_) => getIt<SearchCubit>()),

              BlocProvider<ErrorBloc>.value(value: getIt<ErrorBloc>()),

              BlocProvider<AuthCubit>.value(value: getIt<AuthCubit>()),

              BlocProvider<LinkCubit>(create: (_) => getIt<LinkCubit>()),
            ],
            child: BlocListener<ErrorBloc, ErrorState>(
              listener: (context, state) {
                if (state is ErrorReported) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "${state.failure.message} (${state.failure.code ?? 'нет кода'})",
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: MainLayout(
                headerWidget: showHeader && !Responsive.isMobile(context)
                    ? SearchWidget(currentNodeId: currentNodeId)
                    : const SizedBox(height: 56),
                child: child,
              ),
            ),
          );
        },

        routes: [
          GoRoute(
            name: "node",
            path: "/node/:nodeId",
            pageBuilder: (context, state) {
              final node = state.pathParameters["nodeId"] == "root"
                  ? null
                  : state.pathParameters["nodeId"];

              return NoTransitionPage(
                child: BlocProvider<NodeSortCubit>(
                  create: (_) => NodeSortCubit(),
                  child: DocumentsPage(nodeId: node),
                ),
              );
            },
          ),

          GoRoute(
            name: "documentDetails",
            path: "/node/:nodeId/details/:id",

            builder: (context, state) {
              final documentId = state.pathParameters['id']!;
              return MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (_) =>
                        getIt<DocumentDetailsBloc>()
                          ..add(LoadDocumentDetails(nodeId: documentId)),
                  ),
                ],
                child: DocumentDetailsPage(documentId: documentId),
              );
            },
          ),
        ],
      ),
    ],
  );
}
