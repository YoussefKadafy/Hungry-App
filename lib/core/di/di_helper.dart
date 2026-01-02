import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hungry/core/network/dio_client.dart';
import 'package:hungry/core/network/api_services.dart';

// =========================
// Auth imports
// =========================
import 'package:hungry/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:hungry/features/auth/data/repo/auth_repo.dart';
import 'package:hungry/features/auth/domain/repo/base_auth_repo.dart';
import 'package:hungry/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:hungry/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry/features/home/data/remote_data_source/remote_data_source.dart';
import 'package:hungry/features/home/data/repo/add_to_cart_repo.dart';
import 'package:hungry/features/home/data/repo/home_repo.dart';
import 'package:hungry/features/home/domain/repo/base_home_repo.dart';
import 'package:hungry/features/home/domain/use_cases/add_to_cart_use_case.dart';
import 'package:hungry/features/home/domain/use_cases/home_use_cases.dart';
import 'package:hungry/features/home/domain/use_cases/toppings_and_options_use_case.dart';
import 'package:hungry/features/home/presentation/cubit/add_to_cart_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/category_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/get_products_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/toppins_and_options_cubit.dart';

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

  // ======================================================
  // ========================= AUTH ========================
  // ======================================================

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

  // ======================================================
  // ========================= HOME ========================
  // ======================================================

  // =========================
  // Home - Data
  // =========================
  locator.registerLazySingleton<BaseHomeRemoteDataSource>(
    () => RemoteHomeDataSource(locator<ApiServices>()),
  );

  locator.registerLazySingleton<BaseHomeRepo>(
    () => HomeRepo(locator<BaseHomeRemoteDataSource>()),
  );
  // =========================
  // Home - Domain / UseCases
  // =========================
  locator.registerLazySingleton<HomeUseCases>(
    () => HomeUseCases(locator<BaseHomeRepo>()),
  );
  // =========================
  // Home - Presentation / Cubit
  // =========================
  locator.registerFactory<GetProductsCubit>(
    () => GetProductsCubit(homeUseCases: locator<HomeUseCases>()),
  );
  // ======================================================
  // ======================= TOOPINGS&OPTIONS =====================
  // ======================================================

  // =========================
  // TOOPINGS&OPTIONS - Data
  // =========================

  // =========================
  // TOOPINGS&OPTIONS - Domain / UseCases
  // =========================
  locator.registerLazySingleton<ToppingsAndOptionsUseCase>(
    () => ToppingsAndOptionsUseCase(locator<BaseHomeRepo>()),
  );
  // =========================
  // Products - Presentation / Cubit
  // =========================
  locator.registerFactory(
    () => ToppinsAndOptionsCubit(locator<ToppingsAndOptionsUseCase>()),
  );

  // ======================================================
  // ====================== CATEGORIES ====================
  // ======================================================

  // =========================
  // Categories - Presentation / Cubit
  // =========================
  locator.registerFactory<CategoryCubit>(
    () => CategoryCubit(homeUseCases: locator<HomeUseCases>()),
  );

  // ======================================================
  // ======================= AddToCart =====================
  // ======================================================

  // =========================
  // AddToCart - Data
  // =========================
  locator.registerLazySingleton<AddToCartRepo>(
    () => AddToCartRepo(locator<BaseHomeRemoteDataSource>()),
  );

  // =========================
  // AddToCart - Domain / UseCases
  // =========================
  locator.registerLazySingleton<AddToCartUseCase>(
    () => AddToCartUseCase(locator<AddToCartRepo>()),
  );
  // =========================
  //AddToCart- Presentation / Cubit
  // =========================
  locator.registerLazySingleton<AddToCartCubit>(
    () => AddToCartCubit(locator<AddToCartUseCase>()),
  );
  // ======================================================
  // =======================    =====================
  // ======================================================

  // =========================
  //      - Data
  // =========================

  // =========================
  //      - Domain / UseCases
  // =========================

  // =========================
  //      - Presentation / Cubit
  // =========================

  // ======================================================
  // =======================    =====================
  // ======================================================

  // =========================
  //      - Data
  // =========================

  // =========================
  //      - Domain / UseCases
  // =========================

  // =========================
  //      - Presentation / Cubit
  // =========================

  // ======================================================
  // =======================    =====================
  // ======================================================

  // =========================
  //      - Data
  // =========================

  // =========================
  //      - Domain / UseCases
  // =========================

  // =========================
  //      - Presentation / Cubit
  // =========================

  // ======================================================
  // =======================    =====================
  // ======================================================

  // =========================
  //      - Data
  // =========================

  // =========================
  //      - Domain / UseCases
  // =========================

  // =========================
  //      - Presentation / Cubit
  // =========================

  // ======================================================
  // =======================    =====================
  // ======================================================

  // =========================
  //      - Data
  // =========================

  // =========================
  //      - Domain / UseCases
  // =========================

  // =========================
  //      - Presentation / Cubit
  // =========================
}
