import 'dart:developer';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry/core/consts/app_colors.dart';
import 'package:hungry/core/routing/app_routes.dart';
import 'package:hungry/core/shared/custom_dialog.dart';
import 'package:hungry/core/shared/total_price_and_cart_widget.dart';
import 'package:hungry/core/utils/sized_box_extension.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/data/models/cart_model/cart_model.dart';
import 'package:hungry/features/cart/data/repos/cart_repo.dart';
import 'package:hungry/features/cart/presentation/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});
  static final cartKey = GlobalKey<_CartScreenState>();
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartModel? cartModel;
  CartRepo cartRepo = CartRepo();
  bool isLoading = false;
  String? errorMessage;
  int? removingItemId;
  Future<void> removeItemFromCart(int itemId) async {
    try {
      setState(() => removingItemId = itemId);
      final message = await cartRepo.removeItemFromCart(itemId);

      if (!mounted) return;
      snackBarDialog(
        context,
        message: message,
        type: AnimatedSnackBarType.success,
        title: 'Deleted Successfully',
      );

      await getCart(); // this already updates loading
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> getCart() async {
    try {
      isLoading = true;
      setState(() {});
      final cart = await cartRepo.getCartItems();
      cartModel = cart;
      isLoading = false;
      setState(() {});
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
        errorMessage = e.toString();
        isLoading = false;
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getCart();
  }

  double get totalPrice {
    final items = cartModel?.data?.items ?? [];
    return items.fold(0.0, (sum, item) {
      double price = double.tryParse(item.price?.toString() ?? '0') ?? 0.0;
      int quantity = item.quantity ?? 1;
      return sum + (price * quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _buildBody()),
            24.height,
            TotalPriceAndCartWidget(
              price: '\$ ${totalPrice.toStringAsFixed(2)}',
              title: 'Total',
              buttonText: 'Checkout ',
              iconData: Icon(Icons.payment, color: Colors.white),
              onPressed: () {
                final items = cartModel?.data?.items ?? [];

                final request = CartRequestModel(
                  items: items.map((e) {
                    return CartItemModel(
                      productId: e.productId ?? 0,
                      quantity: e.quantity ?? 1,
                      toppings: e.toppings?.map((t) => t.id!).toList() ?? [],
                      sideOptions:
                          e.sideOptions?.map((s) => s.id!).toList() ?? [],
                    );
                  }).toList(),
                );

                context.pushNamed(
                  AppRoutes.checkout,
                  extra: {
                    'totalPrice': totalPrice.toStringAsFixed(2),
                    'cartRequestModel': request,
                  },
                );
              },
            ),
            16.height,
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    final items = cartModel?.data?.items ?? [];

    if (items.isEmpty) {
      return const Center(child: Text('Your cart is empty'));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: CartItem(
            item: items[index],
            isRemoving: removingItemId == items[index].itemId,
            onIncrease: () {
              setState(() {
                items[index].quantity = items[index].quantity! + 1;
              });
            },
            onDecrease: () {
              if (items[index].quantity! > 1) {
                setState(() {
                  items[index].quantity = items[index].quantity! - 1;
                });
              }
            },
            onRemove: () {
              log(items[index].itemId.toString());
              removeItemFromCart(items[index].itemId!);
            },
          ),
        );
      },
    );
  }
}
