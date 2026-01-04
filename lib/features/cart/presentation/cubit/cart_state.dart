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

  CartSuccess({required this.cartModel, this.removingId});
}
