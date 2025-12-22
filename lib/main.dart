import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:search_frontend/core/theme/theme.dart';
import 'package:search_frontend/core/theme/util.dart';
import 'package:search_frontend/core/utils/injection.dart';
import 'core/utils/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  await setupDI();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Roboto");
    MaterialTheme theme = MaterialTheme(textTheme);

    // return MultiBlocProvider(
    //   providers: [BlocProvider(create: (_) => getIt<AuthCubit>())],
    //   child: MaterialApp.router(
    //     debugShowCheckedModeBanner: false,
    //     theme: theme.light(),
    //     darkTheme: theme.dark(),
    //     themeMode: ThemeMode.system,

    //     routerConfig: AppRouter.goRouter,
    //   ),
    // );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.system,

      routerConfig: AppRouter.goRouter,
    );
  }
}
