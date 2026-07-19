import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/admin/presentation/cubit/zikir_management_cubit.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/auth_usecases.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/home/data/datasources/home_remote_datasource.dart';
import '../../features/home/data/repositories/home_repository_impl.dart';
import '../../features/home/domain/repositories/home_repository.dart';
import '../../features/home/domain/usecases/create_collection.dart';
import '../../features/home/domain/usecases/delete_collection.dart';
import '../../features/home/domain/usecases/get_collections.dart';
import '../../features/home/domain/usecases/update_collection.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/presentation/cubit/profile_cubit.dart';
import '../../features/settings/data/datasources/settings_local_datasource.dart';
import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/domain/usecases/settings_usecases.dart';
import 'package:zikr_app/core/notifications/notification_service.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../../features/tasbeeh/data/datasources/tasbeeh_local_datasource.dart';
import '../../features/tasbeeh/data/datasources/tasbeeh_remote_datasource.dart';
import '../../features/tasbeeh/data/repositories/tasbeeh_repository_impl.dart';
import '../../features/tasbeeh/domain/repositories/tasbeeh_repository.dart';
import '../../features/tasbeeh/domain/usecases/tasbeeh_usecases.dart';
import '../../features/tasbeeh/presentation/cubit/tasbeeh_cubit.dart';
import '../../features/zikir/data/datasources/zikir_remote_datasource.dart';
import '../../features/zikir/data/repositories/zikir_repository_impl.dart';
import '../../features/zikir/domain/repositories/zikir_repository.dart';
import '../../features/zikir/domain/usecases/zikir_usecases.dart';
import '../../features/zikir/presentation/cubit/zikir_cubit.dart';
import '../firebase/firebase_service.dart';
import '../local/local_storage.dart';
import '../navigation/navigation_service.dart';
import '../network/network_info.dart';

final sl = GetIt.instance;

Future<void> initCore() async {
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  await Firebase.initializeApp();
  final firebaseService = FirebaseService();
  await firebaseService.init();
  sl.registerLazySingleton(() => firebaseService);

  final sharedPrefs = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPrefs);
  sl.registerLazySingleton(() => const FlutterSecureStorage());

  final localStorage = await LocalStorage.init();
  sl.registerSingleton<LocalStorage>(localStorage);

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl(), sl()));
  sl.registerLazySingleton(() => NavigationService());

  sl.registerLazySingleton(() => NotificationService());

  sl.registerLazySingleton(() => HomeRemoteDataSource(firebaseService: sl()));
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
      localStorage: sl(),
      firebaseService: sl(),
    ),
  );
  sl.registerLazySingleton(() => GetCollections(sl()));
  sl.registerLazySingleton(() => CreateCollection(sl()));
  sl.registerLazySingleton(() => UpdateCollection(sl()));
  sl.registerLazySingleton(() => DeleteCollection(sl()));
  sl.registerFactory(() => HomeCubit(getCollections: sl()));

  sl.registerLazySingleton<TasbeehLocalDataSource>(
    () => TasbeehLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<TasbeehRemoteDataSource>(
    () => TasbeehRemoteDataSourceImpl(firestore: sl(), firebaseAuth: sl()),
  );
  sl.registerLazySingleton<TasbeehRepositoryImpl>(
    () => TasbeehRepositoryImpl(
      localDataSource: sl<TasbeehLocalDataSource>(),
      remoteDataSource: sl<TasbeehRemoteDataSource>(),
      firebaseAuth: sl(),
    ),
  );
  sl.registerLazySingleton<TasbeehRepository>(
    () => sl<TasbeehRepositoryImpl>(),
  );
  sl.registerLazySingleton(() => GetTasbeehList(sl()));
  sl.registerLazySingleton(() => GetTasbeehTotalCount(sl()));
  sl.registerLazySingleton(() => GetTasbeehStreak(sl()));
  sl.registerLazySingleton(() => UpdateTasbeehCount(sl()));
  sl.registerLazySingleton(
    () => TasbeehCubit(
      getTotalCount: sl(),
      getStreak: sl(),
      updateCount: sl(),
      localDataSource: sl(),
      repositoryImpl: sl<TasbeehRepositoryImpl>(),
    ),
  );

  sl.registerLazySingleton<SettingsLocalDataSource>(
    () => SettingsLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetSettings(sl()));
  sl.registerLazySingleton(() => SaveSettingsItem(sl()));
  sl.registerLazySingleton(() => ToggleDarkMode(sl()));
  sl.registerLazySingleton(() => ChangeLanguage(sl()));
  sl.registerLazySingleton(() => SetNotifications(sl()));
  sl.registerLazySingleton(() => SetMorningReminderTime(sl()));
  sl.registerLazySingleton(() => SetEveningReminderTime(sl()));
  sl.registerFactory(() => SettingsCubit(
        getSettings: sl(),
        toggleDarkMode: sl(),
        changeLanguage: sl(),
        setNotifications: sl(),
        setMorningReminderTime: sl(),
        setEveningReminderTime: sl(),
      ));

  sl.registerLazySingleton<ZikirRemoteDataSource>(
    () => ZikirRemoteDataSourceImpl(firestore: sl(), firebaseAuth: sl()),
  );
  sl.registerLazySingleton<ZikirRepository>(
    () => ZikirRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton(() => GetZikirCategories(sl()));
  sl.registerLazySingleton(() => GetZikirsByCategory(sl()));
  sl.registerLazySingleton(() => ToggleZikirFavorite(sl()));
  sl.registerLazySingleton(() => GetFavoriteZikirs(sl()));
  sl.registerLazySingleton(() => ZikirCubit(repository: sl()));

  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl(), firestore: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), firebaseAuth: sl()),
  );
  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => SignUpWithEmail(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => GetCurrentUser(sl()));
  sl.registerSingleton(
    AuthCubit(
      signInWithEmail: sl(),
      signUpWithEmail: sl(),
      signOut: sl(),
      getCurrentUser: sl(),
    ),
  );

  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(firestore: sl(), firebaseAuth: sl()),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(remoteDataSource: sl(), firebaseAuth: sl()),
  );
  sl.registerSingleton(ProfileCubit(repository: sl()));

  sl.registerSingleton(ZikirManagementCubit());
}
