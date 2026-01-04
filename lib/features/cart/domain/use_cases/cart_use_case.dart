import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/data/models/cart_model/cart_model.dart';
import 'package:hungry/features/cart/domain/repo/base_cart_repo.dart';

class CartUseCase {
  final BaseCartRepo repo;

  CartUseCase(this.repo);

  Future<Either<Failure, CartModel>> getCartItems() => repo.getCartItems();

  Future<Either<Failure, String>> removeItemFromCart({required int id}) =>
      repo.removeItemFromCart(id: id);

  Future<Either<Failure, String>> saveOrder({
    required CartRequestModel request,
  }) => repo.saveOrder(request: request);
}
