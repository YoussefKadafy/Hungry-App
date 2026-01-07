import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hungry/core/shared/snack_bar_dialog.dart';
import 'package:hungry/core/shared/total_price_and_cart_widget.dart';
import 'package:hungry/core/utils/show_cingrats.dart';
import 'package:hungry/core/utils/show_loading_dialog.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/presentation/cubit/add_to_cart_cubit.dart';
import 'package:hungry/features/home/presentation/cubit/add_to_cart_state.dart';

class PriceAndAddingToCart extends StatelessWidget {
  const PriceAndAddingToCart({
    super.key,
    required this.bottomInset,
    required this.product,
    required this.sliderValue,
  });

  final double bottomInset;
  final ProductModel product;
  final double sliderValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 20, offset: Offset(0, 9)),
        ],
      ),
      height: 110.h + bottomInset,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 16 + bottomInset),
      child: BlocListener<AddToCartCubit, AddToCartState>(
        listener: (context, state) {
          if (state is AddToCartError) {
            snackBarDialog(
              context,
              message: state.message,
              type: AnimatedSnackBarType.error,
            );
          }
          if (state is AddToCartLoading) {
            showLoadingDialog(context);
          }
          if (state is AddToCartSuccess) {
            Navigator.pop(context);
            snackBarDialog(
              context,
              message: state.addToCartResponseModel.message,
              type: AnimatedSnackBarType.success,
            );
            showCongrats(context);
          }
        },
        child: TotalPriceAndCartWidget(
          iconData: Icon(Icons.add_shopping_cart, color: Colors.white),
          onPressed: () async {
            final cartItems = CartItemModel(
              productId: product.id,
              quantity: 1,
              toppings: context.read<AddToCartCubit>().toppingsId.toList(),
              sideOptions: context.read<AddToCartCubit>().optionsId.toList(),
              spicy: sliderValue,
            );
            final request = CartRequestModel(items: [cartItems]);
            context.read<AddToCartCubit>().addToCart(request);
          },
          price: '\$ ${product.price}',
          title: 'Total Price',
        ),
      ),
    );
  }
}
