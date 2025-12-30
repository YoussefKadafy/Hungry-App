import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hungry/core/network/dio_client.dart';
import 'package:hungry/core/network/api_services.dart';
import 'package:hungry/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:hungry/features/auth/data/repo/auth_repo.dart';
import 'package:hungry/features/auth/domain/repo/base_auth_repo.dart';
import 'package:hungry/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:hungry/features/auth/presentation/cubit/auth_cubit.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // =========================
  // External / Dio
  // =========================
  locator.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://sonic-zdi0.onrender.com/api',
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    ),
  );

  // =========================
  // Core / DioClient
  // =========================
  locator.registerLazySingleton<DioClient>(() => DioClient(locator<Dio>()));
  locator.registerLazySingleton<ApiServices>(
    () => ApiServices(locator<DioClient>()),
  );

  // =========================
  // Auth - Data
  // =========================
  locator.registerLazySingleton<BaseAuthRemoteDataSource>(
    () => AuthRemoteDataSource(locator<ApiServices>()),
  );

  locator.registerLazySingleton<BaseAuthRepo>(
    () => AuthRepo(locator<BaseAuthRemoteDataSource>()),
  );

  // =========================
  // Auth - Domain / UseCases
  // =========================
  locator.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(locator<BaseAuthRepo>()),
  );

  locator.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(locator<BaseAuthRepo>()),
  );

  // =========================
  // Auth - Presentation / Cubit
  // =========================
  locator.registerFactory<AuthCubit>(
    () => AuthCubit(
      loginUseCase: locator<LoginUseCase>(),
      registerUseCase: locator<RegisterUseCase>(),
    ),
  );
}
