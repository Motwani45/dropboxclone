import 'package:dropboxclone/feature/bloc/auth/auth_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/local/local_cubit.dart';
import 'package:dropboxclone/feature/bloc/file_management/remote/remote_cubit.dart';
import 'package:dropboxclone/feature/data/datasources/auth/auth_datasource.dart';
import 'package:dropboxclone/feature/data/datasources/auth/auth_datasource_impl.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/db_helper.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/firebase_storage_helper.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/local/local_datasource.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/local/local_datasource_impl.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/remote/remote_datasource.dart';
import 'package:dropboxclone/feature/data/datasources/file_management/remote/remote_datasource_impl.dart';
import 'package:dropboxclone/feature/data/repository/auth/auth_repository_impl.dart';
import 'package:dropboxclone/feature/data/repository/file_management/local_repository_impl.dart';
import 'package:dropboxclone/feature/data/repository/file_management/remote_repository_impl.dart';
import 'package:dropboxclone/feature/domain/repository/auth/auth_repository.dart';
import 'package:dropboxclone/feature/domain/repository/file_management/local_repository.dart';
import 'package:dropboxclone/feature/domain/repository/file_management/remote_repository.dart';
import 'package:dropboxclone/feature/domain/usecase/auth/signin_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/auth/signup_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/local/add_file_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/local/change_syncstatus_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/local/get_files_usecase.dart';
import 'package:dropboxclone/feature/domain/usecase/file_management/remote/start_upload_usecase.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  configureCubitResources();
  configureUsecaseResources();
  configureRepositoryResources();
  configureDatasourceResources();
  configureFirebaseResources();
  configureSharedPreferencesResources();
}

void configureCubitResources() {
  sl.registerFactory(() {
    return AuthCubit(signUpUsecase: sl(), signInUsecase: sl());
  });
  sl.registerFactory(() => LocalCubit(
        changeSyncStatusUsecase: sl(),
        getFilesUsecase: sl(),
        addFileUsecase: sl(),
      ));
  sl.registerFactory(() => RemoteCubit(
        startUploadUsecase: sl(),
      ));
}

void configureUsecaseResources() {
  //UseCase
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => SignInUsecase(sl()));
  sl.registerLazySingleton(() => AddFileUsecase(sl()));
  sl.registerLazySingleton(
      () => ChangeSyncStatusUsecase(localRepository: sl()));
  sl.registerLazySingleton(() => GetFilesUsecase(sl()));
  sl.registerLazySingleton(() => StartUploadUsecase(remoteRepository: sl()));
}

void configureRepositoryResources() {
  //Repository
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(authDataSource: sl()));
  sl.registerLazySingleton<LocalRepository>(
      () => LocalRepositoryImpl(dataSource: sl()));
  sl.registerLazySingleton<RemoteRepository>(
      () => RemoteRepositoryImpl(dataSource: sl()));
}

void configureDatasourceResources() {
  //DataSource
  sl.registerLazySingleton<AuthDataSource>(
      () => AuthDataSourceImpl(prefs: sl()));
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(firebaseStorageHelper: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(databaseHelper: sl()));
  sl.registerLazySingleton(() => DatabaseHelper());
  sl.registerLazySingleton(
      () => FirebaseStorageHelper(helper: sl(), firebaseStorage: sl()));
}

void configureFirebaseResources() {
  //Firebase Instance
  sl.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
}

Future<void> configureSharedPreferencesResources() async {
  //SharedPreference Instance
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
