import 'package:dartz/dartz.dart';
import 'package:hungry/core/errors/failure.dart';
import 'package:hungry/features/cart/data/models/add_to_cart_model.dart';
import 'package:hungry/features/cart/data/models/cart_model/cart_model.dart';

abstract class BaseCartRepo {
  Future<Either<Failure, CartModel>> getCartItems();
  Future<Either<Failure, String>> removeItemFromCart({required int id});
  Future<Either<Failure, String>> saveOrder({
    required CartRequestModel request,
  });
}
