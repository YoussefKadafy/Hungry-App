import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/core/shared/custom_text.dart';
import 'package:hungry/core/shared/snack_bar_dialog.dart';
import 'package:hungry/core/shared/total_price_and_cart_widget.dart';
import 'package:hungry/core/utils/show_Dialog.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/data/models/cart_model/cart_model.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:hungry/features/cart/presentation/cubit/cart_state.dart';
import 'package:hungry/features/cart/presentation/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double totalPrice = 0.0;
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
            if (state is CartSuccess) {
              totalPrice = context.read<CartCubit>().calculateTotalPrice(
                cartModel: state.cartModel,
              );
            }
          },
          builder: (context, state) {
            if (context.read<CartCubit>().reloaded == true) {
              snackBarDialog(
                context,
                type: context.read<CartCubit>().message.contains('deleted')
                    ? AnimatedSnackBarType.success
                    : AnimatedSnackBarType.error,
                message: context.read<CartCubit>().message,
              );
            }
            if (state is CartError) {
              return Center(
                child: CustomText(text: state.message, fontSize: 24),
              );
            }
            if (state is CartSuccess) {
              if (state.cartModel.data!.items!.isEmpty) {
                return Center(
                  child: CustomText(text: 'Cart is empty', fontSize: 24),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.cartModel.data?.items?.length ?? 0,
                        itemBuilder: (context, index) {
                          final item = state.cartModel.data?.items?[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: CartItem(
                              item: item!,
                              isRemoving: state.removingId == item.itemId,
                              onIncrease: () {
                                context.read<CartCubit>().increaseQuantity(
                                  item.itemId!,
                                );
                              },
                              onDecrease: () {
                                context.read<CartCubit>().decreaseQuantity(
                                  item.itemId!,
                                );
                              },
                              onRemove: () async {
                                await context.read<CartCubit>().removeItem(
                                  id: item.itemId!,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    24.height,
                    TotalPriceAndCartWidget(
                      price: '\$ $totalPrice ',
                      title: 'Total',
                      buttonText: 'Checkout ',
                      iconData: Icon(Icons.payment, color: Colors.white),
                      onPressed: () {
                        final items = state.cartModel.data?.items ?? [];

                        final request = CartRequestModel(
                          items: items.map((e) {
                            return CartItemModel(
                              productId: e.productId ?? 0,
                              quantity: e.quantity ?? 1,
                              toppings:
                                  e.toppings?.map((t) => t.id!).toList() ?? [],
                              sideOptions:
                                  e.sideOptions?.map((s) => s.id!).toList() ??
                                  [],
                            );
                          }).toList(),
                        );

                        context.pushNamed(
                          AppRoutes.checkout,
                          extra: {
                            'totalPrice': 00,
                            'cartRequestModel': request,
                          },
                        );
                      },
                    ),
                    16.height,
                  ],
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
