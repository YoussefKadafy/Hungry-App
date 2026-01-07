import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/core/shared/loading_state_widget.dart';
import 'package:hungry/core/shared/no_orders.dart';
import 'package:hungry/core/shared/snack_bar_dialog.dart';
import 'package:hungry/core/shared/total_price_and_cart_widget.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_state.dart';
import 'package:hungry/features/cart/presentation/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: BlocConsumer<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartSuccess && state.reloaded) {
              snackBarDialog(
                context,
                type: state.message.contains('deleted')
                    ? AnimatedSnackBarType.success
                    : AnimatedSnackBarType.error,
                message: state.message,
              );
              context.read<CartCubit>().clearReloadFlag();
            }
          },
          builder: (context, state) {
            if (state is CartLoading) {
              return const LoadingStateWidget();
            }

            if (state is CartError) {
              return Center(
                child: IconButton(
                  onPressed: () {
                    context.read<CartCubit>().getCart();
                  },
                  icon: Icon(
                    Icons.replay_outlined,
                    color: AppColors.primaryColor,
                    size: 40,
                  ),
                ),
              );
            }

            if (state is CartSuccess) {
              final items = state.cartModel.data?.items ?? [];

              if (items.isEmpty) {
                return const EmptyStateWidget(text: 'Cart is empty');
              }

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CartItem(
                            item: item,
                            isRemoving: state.removingId == item.itemId,
                            onIncrease: () => context
                                .read<CartCubit>()
                                .increaseQuantity(item.itemId!),
                            onDecrease: () => context
                                .read<CartCubit>()
                                .decreaseQuantity(item.itemId!),
                            onRemove: () => context
                                .read<CartCubit>()
                                .removeItem(id: item.itemId!),
                          ),
                        );
                      },
                    ),
                  ),
                  24.height,
                  TotalPriceAndCartWidget(
                    price: '\$ ${state.totalPrice}',
                    title: 'Total',
                    buttonText: 'Checkout',
                    iconData: const Icon(Icons.payment, color: Colors.white),
                    onPressed: () {
                      final request = CartRequestModel(
                        items: items.map((e) {
                          return CartItemModel(
                            productId: e.productId ?? 0,
                            quantity: e.quantity ?? 1,
                            toppings:
                                e.toppings?.map((t) => t.id!).toList() ?? [],
                            sideOptions:
                                e.sideOptions?.map((s) => s.id!).toList() ?? [],
                          );
                        }).toList(),
                      );

                      context.pushNamed(
                        AppRoutes.checkout,
                        extra: {
                          'totalPrice': state.totalPrice.toString(),
                          'cartRequestModel': request,
                        },
                      );
                    },
                  ),
                  16.height,
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
