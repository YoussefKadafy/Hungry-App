import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';

abstract class AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {}

class AddToCartSuccess extends AddToCartState {
  final AddToCartResponseModel addToCartResponseModel;

  AddToCartSuccess({required this.addToCartResponseModel});
}

class AddToCartError extends AddToCartState {
  final String message;
  AddToCartError({required this.message});
}
