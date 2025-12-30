import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/di/di_helper.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry/features/auth/presentation/screens/login_screen.dart';
import 'package:hungry/features/auth/presentation/screens/register_screen.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/check_out/presentation/screens/checkout_screen.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/presentation/screens/product_details_screen.dart';
import 'package:hungry/root.dart';
import 'package:hungry/splash_screen.dart';

class RoutingConfig {
  static GoRouter routesConfig = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        name: AppRoutes.splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: AppRoutes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => locator<AuthCubit>(),
          child: LoginScreen(),
        ),
      ),

      GoRoute(
        path: AppRoutes.register,
        name: AppRoutes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => locator<AuthCubit>(),
          child: RegisterScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.rootScreen,
        name: AppRoutes.rootScreen,
        builder: (context, state) {
          return const RootScreen();
        },
      ),
      GoRoute(
        path: AppRoutes.productDetails,
        name: AppRoutes.productDetails,
        builder: (context, state) {
          final productDetails = state.extra as ProductModel;
          return ProductDetailsScreen(product: productDetails);
        },
      ),
      GoRoute(
        path: AppRoutes.checkout,
        name: AppRoutes.checkout,
        builder: (context, state) {
          final extraData = state.extra as Map<String, dynamic>;

          final totalPrice = extraData['totalPrice'] as String;
          final cartRequestModel =
              extraData['cartRequestModel'] as CartRequestModel;
          return CheckoutScreen(
            totalPrice: totalPrice,
            cartRequestModel: cartRequestModel,
          );
        },
      ),
    ],
  );
}
