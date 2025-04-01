import 'package:smart_event_planner/core/api/api_client.dart';
import 'package:smart_event_planner/core/api/api_service.dart';
import 'package:smart_event_planner/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:get_it/get_it.dart';
import 'package:smart_event_planner/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:smart_event_planner/features/auth/domain/repositories/auth_repo.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/signin_cubit/signin_cubit.dart';
import 'package:smart_event_planner/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // ------API------

  getIt.registerFactory<ApiServices>(() => ApiServices(
        ApiClient(),
      ));

  // ------Services------
  // --Remote
  getIt.registerFactory<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(getIt<ApiServices>()),
  );

  // ------Repositories------
  getIt.registerFactory<AuthRepo>(() => AuthRepoImpl(
        getIt<AuthRemoteDataSource>(),
      ));

  // ------Cubits------
  getIt.registerFactory<SignInCubit>(() => SignInCubit(
        authRepo: getIt<AuthRepo>(),
      ));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(
        authRepo: getIt<AuthRepo>(),
      ));
}
