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
import 'package:hungry/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:hungry/features/cart/data/data_source/cart_data_source.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'package:hungry/features/cart/domain/repo/base_cart_repo.dart';
import 'package:hungry/features/cart/domain/use_cases/cart_use_case.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:hungry/features/cart/presentation/cubit/save_orders_cubit.dart';
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
import 'package:hungry/features/orderHistory/data/data_source/orders_history_data_source.dart';
import 'package:hungry/features/orderHistory/data/repo/order_history_repo.dart';
import 'package:hungry/features/orderHistory/domain/repo/base_order_history_repo.dart';
import 'package:hungry/features/orderHistory/domain/useCases/order_history_use_cases.dart';
import 'package:hungry/features/orderHistory/presentation/cubit/order_history_cubit.dart';
import 'package:hungry/features/profile/data/data_source/profile_data_source.dart';
import 'package:hungry/features/profile/data/repo/profile_repo.dart';
import 'package:hungry/features/profile/data/repo/update_profile_repo.dart';
import 'package:hungry/features/profile/domain/repo/base_profile_repo.dart';
import 'package:hungry/features/profile/domain/repo/base_update_profile_repo.dart';
import 'package:hungry/features/profile/domain/use_case/profile_use_case.dart';
import 'package:hungry/features/profile/domain/use_case/update_profile_use_case.dart';
import 'package:hungry/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:hungry/features/profile/presentation/cubit/update_profile_cubit.dart';

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
  locator.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCase(locator<BaseAuthRepo>()),
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

  locator.registerFactory<LogoutCubit>(
    () => LogoutCubit(locator<LogoutUseCase>()),
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
  locator.registerFactory<ToppinsAndOptionsCubit>(
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
  locator.registerFactory<AddToCartCubit>(
    () => AddToCartCubit(locator<AddToCartUseCase>()),
  );
  // ======================================================
  // =======================  CART SCREEN   =====================
  // ======================================================

  // =========================
  //   CART   - Data
  // =========================
  locator.registerLazySingleton<BaseRemouteCartDataSource>(
    () => RemouteCartDataSource(locator<ApiServices>()),
  );
  locator.registerLazySingleton<BaseCartRepo>(
    () => CartRepo(locator<BaseRemouteCartDataSource>()),
  );
  // =========================
  //   CART   - Domain / UseCases
  // =========================
  locator.registerLazySingleton<CartUseCase>(
    () => CartUseCase(locator<BaseCartRepo>()),
  );
  // =========================
  //  CART    - Presentation / Cubit
  // =========================
  locator.registerFactory<CartCubit>(() => CartCubit(locator<CartUseCase>()));
  locator.registerLazySingleton<SaveOrdersCubit>(
    () => SaveOrdersCubit(locator<CartUseCase>()),
  );
  // ======================================================
  // ======================= Order Hostory    =====================
  // ======================================================

  // =========================
  //      - Data
  // =========================
  locator.registerLazySingleton<BaseOrderHistoryRemoteDataSource>(
    () => OrdersHistoryRemoteDataSource(locator<ApiServices>()),
  );

  locator.registerLazySingleton<BaseOrderHistoryRepo>(
    () => OrderHistoryRepo(locator<BaseOrderHistoryRemoteDataSource>()),
  );
  // =========================
  //      - Domain / UseCases
  // =========================
  locator.registerLazySingleton<OrderHistoryUseCases>(
    () => OrderHistoryUseCases(locator<BaseOrderHistoryRepo>()),
  );
  // =========================
  //      - Presentation / Cubit
  // =========================
  locator.registerLazySingleton<OrderHistoryCubit>(
    () => OrderHistoryCubit(locator<OrderHistoryUseCases>()),
  );
  // ======================================================
  // =======================  Profile  =====================
  // ======================================================

  // =========================
  //      - Data
  // =========================
  locator.registerLazySingleton<BaseProfileDataSource>(
    () => ProfileDataSource(locator<ApiServices>()),
  );
  locator.registerLazySingleton<BaseProfileRepo>(
    () => ProfileRepo(locator<BaseProfileDataSource>()),
  );
  locator.registerLazySingleton<BaseUpdateProfileRepo>(
    () => UpdateProfileRepo(locator<BaseProfileDataSource>()),
  );
  // =========================
  //      - Domain / UseCases
  // =========================
  locator.registerLazySingleton<ProfileUseCase>(
    () => ProfileUseCase(locator<BaseProfileRepo>()),
  );
  locator.registerLazySingleton<UpdateProfileUseCase>(
    () => UpdateProfileUseCase(locator<BaseUpdateProfileRepo>()),
  );
  // =========================
  //      - Presentation / Cubit
  // =========================
  locator.registerFactory<ProfileCubit>(
    () => ProfileCubit(locator<ProfileUseCase>()),
  );
  locator.registerLazySingleton<UpdateProfileCubit>(
    () => UpdateProfileCubit(locator<UpdateProfileUseCase>()),
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
}
