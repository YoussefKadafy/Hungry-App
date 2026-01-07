import 'package:hungry/features/cart/data/models/cart_model/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartError extends CartState {
  final String message;
  CartError({required this.message});
}

class CartSuccess extends CartState {
  final CartModel cartModel;
  final int? removingId;
  final double totalPrice;
  final String message;
  final bool reloaded;

  CartSuccess({
    required this.cartModel,
    this.removingId,
    this.totalPrice = 0.0,
    this.message = '',
    this.reloaded = false,
  });

  CartSuccess copyWith({
    CartModel? cartModel,
    int? removingId,
    double? totalPrice,
    String? message,
    bool? reloaded,
  }) {
    return CartSuccess(
      cartModel: cartModel ?? this.cartModel,
      removingId: removingId,
      totalPrice: totalPrice ?? this.totalPrice,
      message: message ?? this.message,
      reloaded: reloaded ?? false,
    );
  }
}
