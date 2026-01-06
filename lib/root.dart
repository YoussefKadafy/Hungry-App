import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/di/di_helper.dart';
import 'package:hungry/core/translations/locale_keys.g.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/auth/presentation/auth.dart';
import 'package:hungry/features/auth/presentation/cubit/logout_cubit.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:hungry/features/cart/presentation/screens/cart_screen.dart';
import 'package:hungry/features/home/presentation/cubit/category_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/get_products_cubit.dart';
import 'package:hungry/features/home/presentation/screens/home_screen.dart';
import 'package:hungry/features/orderHistory/presentation/cubit/order_history_cubit.dart';
import 'package:hungry/features/orderHistory/presentation/screens/order_history_screen.dart';
import 'package:hungry/features/profile/presentation/cubit/update_profile_cubit.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

late List<Widget> screens;
int currentIndex = 0;
late PageController _controller;

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    BlocProvider.of<GetProductsCubit>(context).getProducts();
    BlocProvider.of<CategoryCubit>(context).getCategories();
    screens = [
      HomeScreen(),

      BlocProvider(
        create: (context) => locator<CartCubit>(),
        child: CartScreen(),
      ),
      BlocProvider(
        create: (context) => locator<OrderHistoryCubit>(),
        child: const OrderHistoryScreen(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => locator<UpdateProfileCubit>()),
          BlocProvider(create: (context) => locator<LogoutCubit>()),
        ],
        child: const ProfileScreen(),
      ),
    ];
    _controller = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: screens,
        onPageChanged: (value) {
          setState(() {
            currentIndex = value;
          });
        },
      ),
      bottomNavigationBar: Container(
        padding: 8.paddingAll,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: AppColors.white,
          unselectedItemColor: AppColors.grey,

          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;

              _controller.jumpToPage(index);
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: LocaleKeys.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: LocaleKeys.cart.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_restaurant_sharp),
              label: LocaleKeys.orderHistory.tr(),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: LocaleKeys.profile.tr(),
            ),
          ],
        ),
      ),
    );
  }
}
