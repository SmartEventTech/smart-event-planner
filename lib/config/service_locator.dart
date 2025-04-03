import 'package:smart_event_planner/core/api/api_client.dart';
import 'package:smart_event_planner/core/api/api_service.dart';
import 'package:smart_event_planner/core/storage/secure_storage.dart';
import 'package:smart_event_planner/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_event_planner/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:smart_event_planner/features/profile/data/datasources/profile_remote_data_souces.dart';
import 'package:smart_event_planner/features/profile/data/repositories/user_repo_impl.dart';
import 'package:smart_event_planner/features/profile/domain/repositories/user_repo.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_cubit.dart';
import 'package:smart_event_planner/features/profile/presentation/cubits/user_event/user_event_cubit.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // ---------- Api ----------
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  getIt.registerLazySingleton<ApiServices>(
    () => ApiServices(
      getIt<ApiClient>(),
    ),
  );

  // ---------- Auth ----------
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<ApiServices>()),
  );

  // ---------- Secure Storage ----------
  getIt.registerLazySingleton<SecureStorage>(() => SecureStorage());

  getIt.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      getIt<AuthRemoteDataSource>(),
    ),
  );

  getIt.registerFactory<SignInCubit>(
    () => SignInCubit(
      authRepo: getIt<AuthRepo>(),
    ),
  );

  getIt.registerFactory<SignupCubit>(
    () => SignupCubit(
      authRepo: getIt<AuthRepo>(),
    ),
  );

  /// ---------- User ----------
  // -- Remote Data Source
  getIt.registerFactory<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      getIt<ApiServices>(),
    ),
  );
  // -- Repo
  getIt.registerFactory<UserRepo>(
    () => UserRepoImpl(
      getIt<ProfileRemoteDataSource>(),
    ),
  );

  /// -- Cubit
  getIt.registerFactory<UserCubit>(
    () => UserCubit(
      getIt<UserRepo>(),
    ),
  );
  getIt.registerFactory<UserEventCubit>(
    () => UserEventCubit(
      getIt<UserRepo>(),
    ),
  );
}
