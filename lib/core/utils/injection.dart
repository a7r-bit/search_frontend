import 'package:get_it/get_it.dart';
import 'package:search_frontend/core/utils/cubit/ui_state_cubit.dart';
import 'package:search_frontend/core/utils/index.dart';
import 'package:search_frontend/features/auth/data/auth_repository_impl.dart';
import 'package:search_frontend/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:search_frontend/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:search_frontend/features/document_details/data/datasources/document_remote_data_source.dart';
import 'package:search_frontend/features/document_details/data/datasources/document_version_remote_data_source.dart';
import 'package:search_frontend/features/document_details/data/document_repository_impl.dart';
import 'package:search_frontend/features/document_details/data/document_version_repository_impl.dart';
import 'package:search_frontend/features/document_details/domain/repositories/document_repository.dart';
import 'package:search_frontend/features/document_details/domain/repositories/document_version_repository.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_details_bloc.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_upload_bloc.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_version_delete_bloc.dart';
import 'package:search_frontend/features/document_details/presentaition/bloc/document_version_update_bloc.dart';
import 'package:search_frontend/features/document_details/presentaition/cubit/link_cubit.dart';
import 'package:search_frontend/features/documents/data/datasources/file_node_remote_data_source.dart';
import 'package:search_frontend/features/documents/data/datasources/saved_directory_remote_data_source.dart';
import 'package:search_frontend/features/documents/data/directory_repository_impl.dart';
import 'package:search_frontend/features/documents/data/saved_directory_repository_impl.dart';
import 'package:search_frontend/features/documents/domain/repositories/file_node_repository.dart';
import 'package:search_frontend/features/documents/domain/repositories/saved_directory_repository.dart';
import 'package:search_frontend/features/documents/presentation/bloc/dialog_bloc.dart';
import 'package:search_frontend/features/documents/presentation/bloc/directory_bloc.dart';
import 'package:search_frontend/features/documents/presentation/bloc/saved_directories_bloc.dart';
import 'package:search_frontend/features/documents/presentation/cubit/search_cubit.dart';

import '../../features/auth/domain/repositories/auth_repository.dart';

final getIt = GetIt.instance;

Future<void> setupDI() async {
  // Core
  final secureStorage = SecureStorage();
  getIt.registerSingleton<SecureStorage>(secureStorage);

  final apiClient = ApiClient();
  final token = await secureStorage.getAccessToken();
  if (token != null) {
    apiClient.setToken(token);
  }
  getIt.registerSingleton<ApiClient>(apiClient);

  // DataSource
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<SavedDirectoryDataSource>(
    () => SavedDirectoryRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<FileNodeRemoteDataSource>(
    () => DirectoryRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<DocumentVersionRemoteDataSource>(
    () => DocumentVersionRemoteDataSourceImpl(apiClient: getIt()),
  );
  getIt.registerLazySingleton<DocumentRemoteDataSource>(
    () => DocumentRemoteDataSourceImpl(apiClient: getIt()),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt(),
      secureStorage: getIt(),
      apiClient: getIt(),
    ),
  );
  getIt.registerLazySingleton<SavedDirectoryRepository>(
    () => SavedDirectoryRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<FileNodeRepository>(
    () => FileNodeRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<DocumentVersionRepository>(
    () => DocumentVersionRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<DocumentRepository>(
    () => DocumentRepositoryImpl(remoteDataSource: getIt()),
  );

  // Bloc
  getIt.registerSingleton<ErrorBloc>(ErrorBloc());

  getIt.registerSingleton<UiStateCubit>(UiStateCubit());

  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(repository: getIt<AuthRepository>()),
  );
  getIt.registerFactory<SavedDirectoriesBloc>(
    () => SavedDirectoriesBloc(repository: getIt<SavedDirectoryRepository>()),
  );
  getIt.registerFactory<DirectoryBloc>(
    () => DirectoryBloc(repository: getIt<FileNodeRepository>()),
  );
  getIt.registerFactory<SearchCubit>(
    () => SearchCubit(repository: getIt<FileNodeRepository>()),
  );
  getIt.registerFactory<DocumentDetailsBloc>(
    () => DocumentDetailsBloc(
      documentRepository: getIt<DocumentRepository>(),
      documentVersionRepository: getIt<DocumentVersionRepository>(),
    ),
  );
  getIt.registerFactory<DialogBloc>(
    () => DialogBloc(repository: getIt<FileNodeRepository>()),
  );
  getIt.registerFactory<LinkCubit>(() => LinkCubit());

  getIt.registerFactory<DocumentUploadBloc>(
    () => DocumentUploadBloc(
      documentVersionRepository: getIt<DocumentVersionRepository>(),
    ),
  );
  getIt.registerFactory<DocumentVersionUpdateBloc>(
    () => DocumentVersionUpdateBloc(
      repository: getIt<DocumentVersionRepository>(),
    ),
  );
  getIt.registerCachedFactory<DocumentVersionDeleteBloc>(
    () => DocumentVersionDeleteBloc(
      documentVersionRepository: getIt<DocumentVersionRepository>(),
    ),
  );
}
